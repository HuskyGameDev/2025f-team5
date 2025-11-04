extends Resource
class_name Card

enum Types {Movement, Shooting, Special}

@export var cardname: String
@export var effectype: Types
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
