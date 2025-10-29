extends Control

var closed : bool = false
var notif: bool = false

var current_cards = []
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

func _input (event):
	if event.is_action_pressed("DNA"):
		if closed:
			menu_show()
		else:
			menu_hide()
	pass

func _ready():
	Globals.dna_menu = self
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

func get_dna(cards):
	# some barebones UI stuff is here now, definitely needs rework as I'm sure the massive links show
	toggle_notify()
	option_one_name.text = cards[0]["name"]
	option_one_type.text = cards[0]["effect_type"]
	option_one_desc.text = cards[0]["description"]
	option_two_name.text = cards[1]["name"]
	option_two_type.text = cards[1]["effect_type"]
	option_two_desc.text = cards[1]["description"]
	option_three_name.text = cards[2]["name"]
	option_three_type.text = cards[2]["effect_type"]
	option_three_desc.text = cards[2]["description"]
	card_options = cards

func enqueue_dna(cards_queue):
	queued_upgrades.push_back(cards_queue)
	if !notif:
		get_dna(queued_upgrades.pop_front())

func _select_option_one():
	DnaHandler.selected_card(card_options[0])
	toggle_notify()
func _select_option_two():
	DnaHandler.selected_card(card_options[1])
	toggle_notify()
func _select_option_three():
	DnaHandler.selected_card(card_options[2])
	toggle_notify()
