class_name Unibot extends EnemyBase
const enemy_unibot_scene: PackedScene = preload("res://Game/Enemy/unibot.tscn")

var attack_duration : float # how long the enemy attacks for

	# starts attack pattern when the attack cooldown ends
func _on_attack_cooldown_timeout() -> void:
	$Cooldown.set_paused(true)
	$Attacking.set_paused(false)
	get_tree().create_timer(attack_duration).timeout.connect(attack_over)
	

	# shoots a bullet 
func _on_attacking_timeout() -> void:
	var bullet_instance = Bullet.new_bullet(speed, Vector2.LEFT, bullet_lifetime, damage, false, Globals.bullet_types["default"]["sprite"], Globals.bullet_types["default"]["collision_body"])
	get_parent().add_child(bullet_instance)
	bullet_instance.position = position
	bullet_instance.fire()
	

	# resets to idle state after attack
func attack_over() -> void:
	$Cooldown.set_paused(false)
	$Attacking.set_paused(true)
	$EnemyAnimation.play("idle", 1, false)
	

	# sets animation to given animation
func set_animation(animation: String) -> void:
	$EnemyAnimation.play(animation, 1, false)
	

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
	enemy_instance.attack_duration = attack_duration
	return enemy_instance

	# sets bot to idle on load
func _ready() -> void:
	set_cooldown(attack_duration)
	set_animation("idle")
