extends Control

var closed : bool = false
var notif: bool = false

func _input (event):
	if event.is_action_pressed("DNA"):
		if closed:
			menu_show()
		else:
			menu_hide()
	pass

func _ready():
	menu_hide()
	var player = get_tree().get_first_node_in_group("player")
	player.dna_levelup.connect(get_dna)

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
func menu_notify():
	$Movingparts/DnaTab/alert.show()
	notif = true
	if hidden: show()
	menu_hide()

func get_dna(type: String):
	# will be UI stuff here eventually but instead we'll do placeholder
	menu_notify()
	get_tree().create_timer(5).timeout.connect(Callable(self,"temp").bind(type))

func temp(type: String):
	get_tree().get_first_node_in_group("player").dna_changes(type, "all")
	pass
