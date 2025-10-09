class_name EnemyBase extends CharacterBody2D
	#Used to load enemy instances
const enemy_scene: PackedScene = preload("res://Game/enemy_base.tscn")

@export var health = 1.0	# Damage enemy can take before despawning
@export var speed = 0.0	# Movement speed
@export var atkspeed = 2.0	# Time between each bullet fired
var texture

	# Insantiates and fires a bullet at the player whenever its attack cooldown expires
func _on_attack_cooldown_timeout() -> void:
	var bullet_instance = Bullet.new_bullet(100, Vector2.LEFT, 5, 1, false)
	get_parent().add_child(bullet_instance)
	bullet_instance.position = position + Vector2(-50, 0)
	bullet_instance.fire()
	

	# Called on instantiation to set the visual sprite of the enemy
func set_sprite(texture: String) -> void:
	$EnemySprite.texture = texture

	# Called on instantiation to set the attack speed of the enemy
func set_cooldown(time: int) -> void:
	$Cooldown.wait_time = time

	# Creates and returns a new enemy instance
@warning_ignore("shadowed_variable")
static func new_enemy(health: int, speed: int, atkspeed: int, sprite: String) -> CharacterBody2D:
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.health = health
	enemy_instance.speed = speed
	enemy_instance.set_sprite(sprite)
	enemy_instance.set_cooldown(atkspeed)
	return enemy_instance

func _ready() -> void:
	set_cooldown(atkspeed)
	
func death() -> void:
	queue_free()
	
func hit(damage: float) -> void:
	health -= damage
	if (health <= 0):
		death()
