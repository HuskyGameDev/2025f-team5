class_name EnemySlime extends EnemyBase

const enemy_slime_scene: PackedScene = preload("res://Game/Enemy/enemy_slime.tscn")

@warning_ignore("shadowed_variable")
static func new_enemy(texture: String = "res://Art/Enemy/target.png", health: float = 5.0, speed: int = 10, firerate: float = 2.0, damage: float = 1.0, shot_speed: int = 0, bullet_lifetime: float = 4.0) -> CharacterBody2D:
	var enemy_instance = enemy_slime_scene.instantiate()
	enemy_instance.health = health
	enemy_instance.speed = speed
	enemy_instance.firerate = firerate
	enemy_instance.shot_speed = shot_speed
	enemy_instance.bullet_lifetime = bullet_lifetime
	enemy_instance.damage = damage
	enemy_instance.set_cooldown()
	return enemy_instance

# Currently using this to get the position of the player so the enemy can path to them
func find_player() -> Vector2:
	var player = get_tree().get_nodes_in_group("player")
	if len(player) > 0:
		return player[0].global_position
	else:
		return Vector2(0,0)

func _physics_process(delta: float) -> void:
	var player_direction = find_player() - global_position
	velocity = player_direction * speed * delta
	move_and_slide() 
	
# This doesn't work yet
func _on_attack_cooldown_timeout() -> void:
	var bullet_instance = Bullet.new_bullet(shot_speed, Vector2.LEFT, bullet_lifetime, damage, false)
	get_parent().add_child(bullet_instance)
	bullet_instance.position = position
	bullet_instance.fire()
