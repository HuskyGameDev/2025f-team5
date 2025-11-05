class_name Card
extends Resource

@export var cardname: String
@export var effect_type: Globals.Types
@export var description: String
@export var positives: Array[String]
@export var negatives: Array[String]
@export var sprite: Resource
@export var health: int
@export var speed: int
@export var shot_speed: int
@export var bullet_lifetime: float
@export var damage: float
@export var firerate: float
@export var bullet: ResourceBullet

func _init(p_cardname = "", p_effect_type = Globals.Types.Movement, p_description = "", p_positives : Array[String] = [], p_negatives : Array[String] = [], p_sprite = null, p_health = 0, p_speed = 0, p_shot_speed = 0, p_bullet_lifetime = 0, p_damage = 0, p_firerate = 0,  p_bullet = null):
	cardname = p_cardname
	effect_type = p_effect_type
	description = p_description
	positives = p_positives
	negatives = p_negatives
	sprite = p_sprite
	health = p_health
	speed = p_speed
	shot_speed = p_shot_speed
	bullet_lifetime = p_bullet_lifetime
	damage = p_damage
	firerate = p_firerate
	bullet = p_bullet
