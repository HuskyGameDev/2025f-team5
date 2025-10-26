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
