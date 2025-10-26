extends EnemyBase

var attacking = false

func _on_attack_cooldown_timeout() -> void:
	$Cooldown.set_paused(true)
	$AttackDuration.set_paused(false)
	attacking = true

func _on_attack_duration_timeout() -> void:
	$Cooldown.set_paused(false)
	$AttackDuration.set_paused(true)
	attacking = false
	
func set_attack_duration(time: float) -> void:
	$AttackDuration.wait_time = time
	
func _physics_process(delta: float) -> void:
	if(attacking):
		look_at(get_tree().player)
		velocity = transform.x * speed * delta
		move_and_slide()
		



@warning_ignore("shadowed_variable_base_class")
static func new_enemy(_sprite: Sprite2D = null, health: float = 5.0, speed: int = 200, firerate: float = 5, damage: float = 1.0, shot_speed: int = 200, bullet_lifetime: float = 2.0, attack_duration: float = 3) -> CharacterBody2D:
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.health = health
	enemy_instance.speed = speed
	enemy_instance.firerate = firerate
	enemy_instance.shot_speed = shot_speed
	enemy_instance.bullet_lifetime = bullet_lifetime
	enemy_instance.damage = damage
	# enemy_instance.set_sprite(sprite)	# This will not work as Sprite2D cannot be a String
	enemy_instance.set_cooldown(firerate)
	enemy_instance.set_attack_duration(attack_duration)
	return enemy_instance
