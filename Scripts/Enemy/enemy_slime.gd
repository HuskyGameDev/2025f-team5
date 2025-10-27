class_name EnemySlime extends EnemyBase

@warning_ignore("shadowed_variable")
static func new_enemy_slime(health: float = 5.0, speed: int = 100, firerate: float = 2.0, damage: float = 1.0, shot_speed: int = 0, bullet_lifetime: float = 5.0) -> CharacterBody2D:
	return new_enemy(health, speed, firerate, damage, shot_speed, bullet_lifetime)

func find_player() -> Vector2:
	var player = get_tree().get_nodes_in_group("player")
	if len(player) > 0:
		return player[0].global_position
	else:
		return Vector2(0,0)
	

func _physics_process(delta: float) -> void:
	var direction = find_player() - global_position
	velocity = direction * speed
	move_and_slide() 
