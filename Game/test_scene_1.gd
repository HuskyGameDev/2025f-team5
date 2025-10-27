extends Node2D

func _ready():
	get_tree().create_timer(4).timeout.connect(byeah)

func byeah():
	var player = $Player
	player.gain_dna("mini", 1)
