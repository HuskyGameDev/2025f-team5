extends Node2D

func _process(_delta: float) -> void:
	if(!(get_parent().is_alive)):
		return
	look_at(get_global_mouse_position())
