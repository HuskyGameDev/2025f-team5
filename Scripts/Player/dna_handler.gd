extends Node

@export var current_dna = {}

func reset_current_dna() -> void:
	for dna_type in Globals.dna_types.keys():
		current_dna[dna_type] = 0

func gain_dna(dna_type: String, quantity: int):
	current_dna[dna_type] += quantity
