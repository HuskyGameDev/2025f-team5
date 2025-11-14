extends Node2D

@export var dna_type: ResourceDna

func _ready():
	print(Globals.Types.Movement)
	get_tree().create_timer(4).timeout.connect(byeah)

func byeah():
	#print(dna_type)
	#DnaHandler.gain_dna(dna_type, 20)
	#DnaHandler.pop_queue()
	#DnaHandler.gain_dna("mini", 20)
	#DnaHandler.pop_queue()
	pass
