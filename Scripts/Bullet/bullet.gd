class_name Bullet extends Area2D

const bullet_scene : PackedScene = preload("res://Game/Bullet/bullet.tscn")

var speed : int				# bullet speed in pixels?
var lifetime : float		# lifetime of the bullet in seconds
var damage : float			# damage
var direction : Vector2		# bullet direction
var player_bullet : bool 			# true = player

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta


@warning_ignore("shadowed_variable")
static func new_bullet(speed: int, direction: Vector2, lifetime: float, damage: float, player_bullet: bool, bullet_resource: ResourceBullet) -> Bullet:
	var bullet_instance = bullet_scene.instantiate()
	var sprite = bullet_resource.bullet_sprite
	var collision_body_2d = bullet_resource.bullet_hitbox
	bullet_instance.find_child("Sprite2D", false).texture = sprite
	bullet_instance.find_child("CollisionShape2D", false).shape = collision_body_2d
	bullet_instance.set_process(false)
	bullet_instance.speed = speed
	bullet_instance.lifetime = lifetime
	bullet_instance.damage = damage
	bullet_instance.direction = direction
	bullet_instance.player_bullet = player_bullet # change this later
	return bullet_instance

func fire() -> void:
	look_at(direction)
	set_process(true)
	$Lifetime.wait_time = lifetime
	$Lifetime.start()


func _on_body_entered(body) -> void:
	if body is EnemyBase && self.player_bullet: # non enemy bullet hit enemy
		body.hit(damage)
		despawn()
	elif body.is_in_group("player") && !self.player_bullet: # non player bullet hit player
		body.hit()	# no damage due to health being based on hits instead of value
		despawn()
	elif body is TileMapLayer: # hit the wall
		despawn()

func despawn() -> void:
	$Lifetime.stop() # prevent issue where timer attempts to trigger when bullet is freed
	queue_free()


func _on_lifetime_timeout() -> void:
	despawn()
