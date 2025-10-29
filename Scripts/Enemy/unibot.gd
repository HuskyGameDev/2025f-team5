class_name Unibot extends EnemyBase
const enemy_unibot_scene: PackedScene = preload("res://Game/Enemy/unibot.tscn")

var attack_duration : float # how long the enemy attacks for

	# Insantiates and fires a bullet at the player whenever its attack cooldown expires
func _on_attack_cooldown_timeout() -> void:
	var bullet_instance = Bullet.new_bullet(speed, Vector2.LEFT, bullet_lifetime, damage, false, Globals.bullet_types["default"]["sprite"], Globals.bullet_types["default"]["collision_body"])
	get_parent().add_child(bullet_instance)
	bullet_instance.position = position
	bullet_instance.fire()
	

	# Called on instantiation to set the animation sprite of the enemy
func set_animation(animation: String) -> void:
	$EnemyAnimation.play(animation, 1, false)

	# Called on instantiation to set the attack speed of the enemy
func set_cooldown(time: float) -> void:
	$Cooldown.wait_time = time

	# Creates and returns a new enemy instance
@warning_ignore("shadowed_variable_base_class", "shadowed_variable")
static func new_enemy(_sprite: Sprite2D = null, health: float = 5.0, speed: int = 200, firerate: float = 2.0, damage: float = 1.0, shot_speed: int = 200, bullet_lifetime: float = 2.0, attack_duration: float = 4.0) -> CharacterBody2D:
	var enemy_instance = enemy_unibot_scene.instantiate()
	enemy_instance.health = health
	enemy_instance.speed = speed
	enemy_instance.firerate = firerate
	enemy_instance.shot_speed = shot_speed
	enemy_instance.bullet_lifetime = bullet_lifetime
	enemy_instance.damage = damage
	enemy_instance.set_cooldown(firerate)
	enemy_instance.attack_duration = attack_duration
	enemy_instance.set_animation("idle")
	return enemy_instance
