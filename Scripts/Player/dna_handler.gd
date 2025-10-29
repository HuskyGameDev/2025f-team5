extends Node

@export var current_dna = {}
var queued_upgrades = []

var current_cards = []

func reset_current_dna() -> void:
	for dna_type in Globals.dna_types.keys():
		current_dna[dna_type] = 0

func gain_dna(dna_type: String, quantity: int):
	current_dna[dna_type] = current_dna.get(dna_type, 0) + quantity
	var threshold = Globals.dna_types[dna_type]["threshold"]
	if current_dna[dna_type] >= threshold:
		current_dna[dna_type] -= threshold
		queued_upgrades.push_back(dna_type)

func queue_size():
	return queued_upgrades.size()

func pop_queue():
	if queued_upgrades.size() > 0:
		send_cards()

func send_cards():
	var dna_type = queued_upgrades.pop_front()
	var cards = Globals.dna_types[dna_type]["cards"]
	var card_options = []
	randomize()
	card_options.push_back(cards.pick_random())
	cards.erase(card_options[0])
	card_options.push_back(cards.pick_random())
	cards.erase(card_options[1])
	card_options.push_back(cards.pick_random())
	$"../Main/CanvasLayer/UI/DnaMenu".get_dna(card_options)

func selected_card(card):
	current_cards.push_back(card)
	get_tree().get_first_node_in_group("player").dna_changes(card)
	if queued_upgrades.size() > 0:
		send_cards()

func calculate_changes():
	pass
