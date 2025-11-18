extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Area2D.set_deferred("monitoring", false)
		$Area2D.set_deferred("monitorable", false)
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		spawn_enemies()
		
		
func spawn_enemies() -> void:
	for marker : Marker2D in $EnemySpawnpoints.get_children():
		var enemy : EnemyBase = choose_enemy_class()
		enemy.position = marker.position
		add_child(enemy)
		print("balls");
		
func choose_enemy_class() -> EnemyBase:
	match randi() % 2:
		0:
			return EnemySlime.new_enemy()
		1:
			return Unibot.new_enemy()
		_:
			return EnemyBase.new_enemy()
