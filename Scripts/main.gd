extends Node2D

# resets the game when the player presses R
func _process(_delta: float) -> void:
	if Input.is_action_pressed("Reset"):
		DnaHandler.reset_current_dna()
		get_tree().reload_current_scene()
