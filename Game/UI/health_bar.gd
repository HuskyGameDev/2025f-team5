extends Node2D

@onready var thelabel := $RichTextLabel

func _ready():
	thelabel.text = "Health: %d" % Globals.player_base["health"]

func update_health(newhealth: int):
	thelabel.text = "Health: %d" % newhealth
