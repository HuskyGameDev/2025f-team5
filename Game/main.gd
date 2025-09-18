extends Node2D

# onready variables run when the scene enters the scene tree
@onready var first_scene = load("res://Game/test_scene_1.tscn") # Grabs the scene as a packed scene
@onready var instance = first_scene.instantiate() # Unpacks the scene into a collection of nodes

# _ready() runs when the scene enters the scene tree
func _ready():
	add_child(instance) # adds the collection of nodes as a child of main

# _process() runs every frame
# delta is the duration of time since the previous frame
func _process(delta):
	# Dash is the spacebar currently
	if Input.is_action_just_pressed("Dash"):
		remove_child(instance)  # Removes instance and its children
		first_scene = load("res://Game/test_scene_2.tscn") # repeats the previous steps
		instance = first_scene.instantiate()
		add_child(instance)
	
