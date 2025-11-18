extends Node

# Hardcoded for now, rooms can be level specific once we are further in development

@onready var starting_room = load("res://Game/Room/starting_room.tscn")
@onready var room1 = load("res://Game/Room/room_1.tscn")
@onready var room2 = load("res://Game/Room/room_2.tscn")
@onready var room3 = load("res://Game/Room/room_3.tscn")
@onready var room4 = load("res://Game/Room/room_4.tscn")
@onready var room5 = load("res://Game/Room/room_5.tscn")
@onready var room6 = load("res://Game/Room/room_6.tscn")
@onready var room7 = load("res://Game/Room/room_7.tscn")
@onready var room8 = load("res://Game/Room/room_8.tscn")
@onready var room9 = load("res://Game/Room/room_9.tscn")
@onready var room10 = load("res://Game/Room/room_10.tscn")

var available_rooms = [room1, room2, room3, room4, room5, room6, room7, room8, room9, room10]
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



# 
#
#
#
#
func test_setup() -> void:
			# available_rooms.shuffle()
	# for room in available_rooms:
	
	#map[entry.x].push_back(room1);
	#map[entry.x + 1].push_back(room2);
	#map[entry.x].push_back(room3);
	
	starting_room = starting_room.instantiate()
	room1 = room1.instantiate()
	room2 = room2.instantiate()
	room3 = room3.instantiate()
	room4 = room4.instantiate()
	room5 = room5.instantiate()
	room6 = room6.instantiate()
	room7 = room7.instantiate()
	room8 = room8.instantiate()
	room9 = room9.instantiate()
	room10 = room10.instantiate()
	add_child(starting_room)
	add_child(room1)
	add_child(room2)
	add_child(room3)
	add_child(room4)
	add_child(room5)
	add_child(room6)
	add_child(room7)
	add_child(room8)
	add_child(room9)
	add_child(room10)
	
	starting_room.global_position = Vector2(0,0)
	room1.global_position = Vector2(768, 0)
	room2.global_position = Vector2((768*2), (512*2))
	room3.global_position = Vector2(768, 512)
	room4.global_position = Vector2(768, (512*2))
	room5.global_position = Vector2((768*2), 0)
	room6.global_position = Vector2((768*3), 0)
	room7.global_position = Vector2((768*2), -512)
	room8.global_position = Vector2((768*3), -512)
	room9.global_position = Vector2(768, -512)
	room10.global_position = Vector2((768*2), -(512*2))
	
