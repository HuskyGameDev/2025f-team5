extends Node

@export var current_dna = {}
var queued_upgrades = []

var current_cards = []


#possibly in future make so that deletes keys?
# - for showing dna thresholds to player, reduce bloat after respec?
func reset_current_dna() -> void:
	for dna_type in current_cards:
		current_cards.pop_back()
	calculate_changes()


#func gain_dna(dna_type: String, quantity: int):
	#current_dna[dna_type] = current_dna.get(dna_type, 0) + quantity
	#var threshold = Globals.dna_types[dna_type]["threshold"]
	#if current_dna[dna_type] >= threshold:
		#current_dna[dna_type] -= threshold
		#queued_upgrades.push_back(dna_type)

func gain_dna(dna: ResourceDna, quantity: int):
	var dna_type = dna.dna_name
	current_dna[dna_type] = current_dna.get(dna_type, 0) + quantity
	var threshold = dna.dna_threshold
	while current_dna[dna_type] >= threshold:
		current_dna[dna_type] -= threshold
		queued_upgrades.push_back(dna)

func queue_size():
	return queued_upgrades.size()

func pop_queue():
	if queued_upgrades.size() > 0:
		send_cards()

#func send_cards():
	#var dna_type = queued_upgrades.pop_front()
	#var cards = Globals.dna_types[dna_type]["cards"] 
	#var card_options = []
	## randomize()
	#card_options.push_back(cards.pick_random())
	#cards.erase(card_options[0])
	#card_options.push_back(cards.pick_random())
	#cards.erase(card_options[1])
	#card_options.push_back(cards.pick_random())
	#$"../Main/CanvasLayer/UI/DnaMenu".get_dna(card_options)

func send_cards():
	var dna = queued_upgrades.pop_front()
	var cardcount = dna.cards.size()
	var indexes : Array[int] = []
	while indexes.size() != 3:
		var index = randi() % cardcount
		if index in indexes:
			pass
		else:
			indexes.push_back(index)
	$"../Main/CanvasLayer/UI/DnaMenu".get_dna(dna, indexes)

#func selected_card(card):
	#current_cards.push_back(card)
	#if queued_upgrades.size() > 0:
		#send_cards()
	#else:
		#get_tree().get_first_node_in_group("player").update_stats(calculate_changes())

func selected_card(dna: ResourceDna, index):
	current_cards.push_back(dna.cards[index])
	if queued_upgrades.size() > 0:
		send_cards()
	else:
		get_tree().get_first_node_in_group("player").update_stats(calculate_changes())

#func calculate_changes():
	#var updated_stats = Globals.player_base
	#updated_stats["bullet"] = null
	#for card in current_cards:
		#updated_stats["health"] += card["health"]
		#updated_stats["speed"] += card["speed"]
		#updated_stats["shot_speed"] += card["shot_speed"]
		#updated_stats["bullet_lifetime"] += card["bullet_lifetime"]
		#updated_stats["damage"] += card["damage"]
		#updated_stats["firerate"] += card["firerate"]
		#updated_stats["bullet"] = card["bullet"] if card["bullet"] != null else updated_stats["bullet"]
	#return updated_stats

func calculate_changes():
	# duplicate(true) creates a deep copy of the dictionary
	var updated_stats = Globals.player_base.duplicate(true)
	updated_stats["bullet"] = null
	for card in current_cards:
		updated_stats["health"] += card.health
		updated_stats["speed"] += card.speed
		updated_stats["shot_speed"] += card.shot_speed
		updated_stats["bullet_lifetime"] += card.bullet_lifetime
		updated_stats["damage"] += card.damage
		updated_stats["firerate"] += card.firerate
		updated_stats["bullet"] = card.bullet if card.bullet != null else updated_stats["bullet"]
	return updated_stats
