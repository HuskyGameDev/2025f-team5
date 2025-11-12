extends Node

# Hardcoded for now, rooms can be level specific once we are further in development

@onready var starting_room = load("res://Game/Room/starting_room.tscn")
@onready var room1 = load("res://Game/Room/room_1.tscn")
@onready var room2 = load("res://Game/Room/room_2.tscn")
@onready var room3 = load("res://Game/Room/room_3.tscn")

var available_rooms = [room1, room2, room3]
var map = []
var width : int = 5
var height : int = 5
var entry : Vector2i = Vector2i(0,2)

func _ready() -> void:
	reset_map()
	test_setup()

func reset_map(map_width : int = 5, map_height : int = 5, start_at: Vector2i = Vector2i(0,2)) -> void:
	width = map_width
	height = map_height
	entry = start_at
	map = []
	for i in range(width):
		map.push_back([])


func test_setup() -> void:
			# available_rooms.shuffle()
	# for room in available_rooms:
	
	map[entry.x].push_back(room1);
	map[entry.x + 1].push_back(room2);
	map[entry.x].push_back(room3);
	
	starting_room = starting_room.instantiate()
	room1 = room1.instantiate()
	room2 = room2.instantiate()
	room3 = room3.instantiate()
	add_child(starting_room)
	add_child(room1)
	add_child(room2)
	add_child(room3)
	
	starting_room.global_position = Vector2(0,0)
	room1.global_position = Vector2(768, 0)
	room2.global_position = Vector2((768*2), 0)
	room3.global_position = Vector2(768, 512)
	
