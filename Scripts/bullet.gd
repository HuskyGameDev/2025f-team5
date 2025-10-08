class_name Bullet extends Area2D

const bullet_scene : PackedScene = preload("res://Game/bullet.tscn")

var speed : int				# bullet speed in pixels?
var lifetime : float		# lifetime of the bullet in seconds
var damage : float			# damage
var direction : Vector2		# bullet direction

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta


@warning_ignore("shadowed_variable")
static func new_bullet(speed: int, direction: Vector2, lifetime: float, damage: float) -> Bullet:
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.set_process(false)
	bullet_instance.speed = speed
	bullet_instance.lifetime = lifetime
	bullet_instance.damage = damage
	bullet_instance.direction = direction
	return bullet_instance

func fire() -> void:
	look_at(direction)
	set_process(true)
	despawn()


func _on_body_entered(body) -> void:
	queue_free()


func despawn() -> void:
	await get_tree().create_timer(lifetime).timeout
	queue_free()
	
