extends Node2D

func _ready():
	get_tree().create_timer(4).timeout.connect(byeah)

func byeah():
	DnaHandler.gain_dna("mini", 20)
	DnaHandler.pop_queue()
