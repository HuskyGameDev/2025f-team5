extends Node2D

const door : PackedScene = preload("res://Game/Room/door.tscn")

var doors : Array[Node2D] = []
var enemy_count : int = 0
var triggered : bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Area2D.set_deferred("monitoring", false)
		$Area2D.set_deferred("monitorable", false)
		$Area2D/CollisionPolygon2D.set_deferred("disabled", true)
		spawn_doors() 
		spawn_enemies()
		triggered = true
		
		
func spawn_enemies() -> void:
	for marker : Marker2D in $EnemySpawnpoints.get_children():
		var enemy : EnemyBase = choose_enemy_class()
		enemy.position = marker.position
		enemy.on_death.connect(_on_enemy_death)
		call_deferred("add_child", enemy) # further testing needs to check if this function waits a frame to spawn each enemy
		enemy_count += 1
		

# hey p_door, im a door! That reminds me of the time when I was a door in AimAlgam!
func spawn_doors() -> void:
	if has_node("UpDoor"):
		var p_door : Node2D = door.duplicate(true).instantiate() 
		p_door.position = $UpDoor.position
		p_door.rotation_degrees = 0
		call_deferred("add_child", p_door)
		doors.push_back(p_door)
	if has_node("LeftDoor"):
		var p_door : Node2D = door.duplicate(true).instantiate()
		p_door.position = $LeftDoor.position
		p_door.rotation_degrees = -90
		call_deferred("add_child", p_door)
		doors.push_back(p_door)
	if has_node("RightDoor"):
		var p_door : Node2D = door.duplicate(true).instantiate()
		p_door.position = $RightDoor.position
		p_door.rotation_degrees = 90
		call_deferred("add_child", p_door)
		doors.push_back(p_door)
	if has_node("DownDoor"):
		var p_door : Node2D = door.duplicate(true).instantiate()
		p_door.position = $DownDoor.position
		p_door.rotation_degrees = 180
		call_deferred("add_child", p_door)
		doors.push_back(p_door)

func _on_enemy_death() -> void:
	enemy_count -= 1
	if enemy_count <= 0:
		for temp_door : Node2D in doors:
			temp_door.queue_free()

func choose_enemy_class() -> EnemyBase:
	match randi() % 3:
		0:
			return EnemySlime.new_enemy()
		1:
			return Unibot.new_enemy()
		2:
			return EvilSnake.new_enemy()
		_:
			return EnemyBase.new_enemy()
