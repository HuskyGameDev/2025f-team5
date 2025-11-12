class_name EnemyBase extends CharacterBody2D
	#Used to load enemy instances
const enemy_scene: PackedScene = preload("res://Game/Enemy/enemy_base.tscn")

@export var bullet_resource: ResourceBullet
@export var dna_type: ResourceDna
@export var dna_drop_amount: int

var health : float			# Damage enemy can take before despawning
var speed : int				# Movement speed
var shot_speed : int			# Speed of shots
var bullet_lifetime : float	# Bullet lifetime (in seconds)
var firerate : float			# Cooldown between shots
var damage : float			# Damage bullets do

	# Insantiates and fires a bullet at the player whenever its attack cooldown expires
func _on_attack_cooldown_timeout() -> void:
	var bullet_instance = Bullet.new_bullet(speed, Vector2.LEFT, bullet_lifetime, damage, false, bullet_resource)
	get_parent().add_child(bullet_instance)
	bullet_instance.position = position
	bullet_instance.fire()
	

	# Called on instantiation to set the visual sprite of the enemy
func set_sprite(sprite: Sprite2D) -> void:
	$EnemySprite.texture = sprite

	# Called on instantiation to set the attack speed of the enemy
func set_cooldown(time: float) -> void:
	$Cooldown.wait_time = time

	# Creates and returns a new enemy instance
@warning_ignore("shadowed_variable")
static func new_enemy(_sprite: Sprite2D = null, health: float = 5.0, speed: int = 200, firerate: float = 0.5, damage: float = 1.0, shot_speed: int = 200, bullet_lifetime: float = 2.0) -> CharacterBody2D:
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.health = health
	enemy_instance.speed = speed
	enemy_instance.firerate = firerate
	enemy_instance.shot_speed = shot_speed
	enemy_instance.bullet_lifetime = bullet_lifetime
	enemy_instance.damage = damage
	# enemy_instance.set_sprite(sprite)	# This will not work as Sprite2D cannot be a String
	enemy_instance.set_cooldown(firerate)
	return enemy_instance

func _ready() -> void:
	set_cooldown(firerate)
	
func death() -> void:
	DnaHandler.gain_dna(dna_type, dna_drop_amount)
	Globals.enemies_alive -= 1
	if Globals.enemies_alive == 0:
		DnaHandler.pop_queue()
	queue_free()

func hit(damage_dealt: float) -> void:
	health -= damage_dealt
	if (health <= 0):
		death()
