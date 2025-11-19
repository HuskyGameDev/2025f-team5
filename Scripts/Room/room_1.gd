extends Node2D

var enemy_count : int = 0
var triggered : bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Area2D.set_deferred("monitoring", false)
		$Area2D.set_deferred("monitorable", false)
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		spawn_enemies()
		triggered = true
		
		
func spawn_enemies() -> void:
	for marker : Marker2D in $EnemySpawnpoints.get_children():
		var enemy : EnemyBase = choose_enemy_class()
		enemy.position = marker.position
		enemy.on_death.connect(_on_enemy_death)
		call_deferred("add_child", enemy) # further testing needs to check if this function waits a frame to spawn each enemy
		enemy_count += 1
		

func _on_enemy_death() -> void:
	enemy_count -= 1

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
