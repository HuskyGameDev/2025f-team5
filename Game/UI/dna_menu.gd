extends Control

var closed : bool = false

func _input (event):
	if event.is_action_pressed("DNA"):
		if closed:
			$Movingparts.position.x = 0
			$Movingparts.position.y = 0
			closed = false
		else:
			$Movingparts.position = $MenuClosedLocation.position
			closed = true
	pass

func _ready():
	$Movingparts.position = $MenuClosedLocation.position
	closed = true
	var player = get_tree().get_first_node_in_group("player")
	player.dna_levelup.connect(get_dna)

func get_dna(type: String):
	if closed:
		$Movingparts.position.x = 0
		$Movingparts.position.y = 0
		closed = false
	else:
		$Movingparts.position = $MenuClosedLocation.position
		closed = true
	pass
