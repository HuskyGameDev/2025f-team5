extends Control

var closed : bool = false
var notif: bool = false

var current_cards = []
var current_dna: ResourceDna
var current_dna_indexes = []

var card_options = []
var queued_upgrades = []


@onready var mutations_container := $Movingparts/DnaPanel/MarginContainer/Mutations
@onready var mutations_options := $Movingparts/DnaPanel/MarginContainer/MutationOptions

# shortening option
# @export var testoptionname : Label

# Temp variables to solve the issue of long links
@onready var option_one_name := $Movingparts/DnaPanel/MarginContainer/MutationOptions/Categories/OptionOne/MarginContainer/VBoxContainer/CardName
@onready var option_one_type := $Movingparts/DnaPanel/MarginContainer/MutationOptions/Categories/OptionOne/MarginContainer/VBoxContainer/DnaType
@onready var option_one_desc := $Movingparts/DnaPanel/MarginContainer/MutationOptions/Categories/OptionOne/MarginContainer/VBoxContainer/DnaDesc
@onready var option_two_name := $Movingparts/DnaPanel/MarginContainer/MutationOptions/Categories/OptionTwo/MarginContainer/VBoxContainer/CardName
@onready var option_two_type := $Movingparts/DnaPanel/MarginContainer/MutationOptions/Categories/OptionTwo/MarginContainer/VBoxContainer/DnaType
@onready var option_two_desc := $Movingparts/DnaPanel/MarginContainer/MutationOptions/Categories/OptionTwo/MarginContainer/VBoxContainer/DnaDesc
@onready var option_three_name := $Movingparts/DnaPanel/MarginContainer/MutationOptions/Categories/OptionThree/MarginContainer/VBoxContainer/CardName
@onready var option_three_type := $Movingparts/DnaPanel/MarginContainer/MutationOptions/Categories/OptionThree/MarginContainer/VBoxContainer/DnaType
@onready var option_three_desc := $Movingparts/DnaPanel/MarginContainer/MutationOptions/Categories/OptionThree/MarginContainer/VBoxContainer/DnaDesc

# These are for proof of concept for displaying current dna, unfinished.
@onready var card_one_name := $Movingparts/DnaPanel/MarginContainer/Mutations/Categories/Movement/MarginContainer/VBoxContainer/CardName
@onready var card_one_type := $Movingparts/DnaPanel/MarginContainer/Mutations/Categories/Movement/MarginContainer/VBoxContainer/DnaType
@onready var card_one_desc := $Movingparts/DnaPanel/MarginContainer/Mutations/Categories/Movement/MarginContainer/VBoxContainer/DnaDesc

func _input (event):
	if event.is_action_pressed("DNA"):
		if closed:
			menu_show()
		else:
			menu_hide()
	pass

func _ready():
	menu_hide()

func menu_hide():
	if notif == false:
		hide()
		closed = true
	else:
		$Movingparts.position = $MenuNotifyLocation.position
		closed = true
func menu_show():
	if hidden: show()
	$Movingparts.position.x = 0
	$Movingparts.position.y = 0
	closed = false
func toggle_notify():
	if !notif:
		$Movingparts/DnaTab/alert.show()
		notif = true
		if hidden: show()
		mutations_container.hide()
		mutations_options.show()
		if closed: menu_hide()
	else:
		$Movingparts/DnaTab/alert.hide()
		notif = false
		mutations_container.show()
		mutations_options.hide()
		if !closed: menu_hide()

#func get_dna(cards):
	#toggle_notify()
	#option_one_name.text = cards[0]["name"]
	#option_one_type.text = cards[0]["effect_type"]
	#option_one_desc.text = cards[0]["description"]
	#option_two_name.text = cards[1]["name"]
	#option_two_type.text = cards[1]["effect_type"]
	#option_two_desc.text = cards[1]["description"]
	#option_three_name.text = cards[2]["name"]
	#option_three_type.text = cards[2]["effect_type"]
	#option_three_desc.text = cards[2]["description"]
	#card_options = cards

func get_dna(dna, indexes: Array[int]):
	toggle_notify()
	option_one_name.text = dna.cards[indexes[0]].cardname
	option_one_type.text = Globals.name_from_type[dna.cards[indexes[0]].effect_type]
	option_one_desc.text = dna.cards[indexes[0]].description
	option_two_name.text = dna.cards[indexes[1]].cardname
	option_two_type.text = Globals.name_from_type[dna.cards[indexes[0]].effect_type]
	option_two_desc.text = dna.cards[indexes[1]].description
	option_three_name.text = dna.cards[indexes[2]].cardname
	option_three_type.text = Globals.name_from_type[dna.cards[indexes[0]].effect_type]
	option_three_desc.text = dna.cards[indexes[2]].description
	current_dna = dna
	current_dna_indexes = indexes

#func enqueue_dna(cards_queue):
	#queued_upgrades.push_back(cards_queue)
	#if !notif:
		#get_dna()

func _select_option_one():
	DnaHandler.selected_card(current_dna, current_dna_indexes[0])
	add_card(current_dna_indexes[0])
	toggle_notify()
func _select_option_two():
	DnaHandler.selected_card(current_dna, current_dna_indexes[1])
	add_card(current_dna_indexes[1])
	toggle_notify()
func _select_option_three():
	DnaHandler.selected_card(current_dna, current_dna_indexes[2])
	add_card(current_dna_indexes[2])
	toggle_notify()

#func add_card(card):
	#card_one_name.text = card["name"]
	#card_one_type.text = card["effect_type"]
	#card_one_desc.text = card["description"]

func add_card(index):
	card_one_name.text = current_dna.cards[index].cardname
	card_one_type.text = Globals.name_from_type[current_dna.cards[index].effect_type]
	card_one_desc.text = current_dna.cards[index].description
