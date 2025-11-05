extends Resource
class_name ResourceDna

@export var dna_name: String
@export var dna_threshold: int

@export var cards: Array[Card]

func _init(p_dna_name = "", p_dna_threshold = 0, p_cards : Array[Card] = []):
	dna_name = p_dna_name
	dna_threshold = p_dna_threshold
	cards = p_cards
