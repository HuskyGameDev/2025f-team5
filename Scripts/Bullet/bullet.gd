class_name Bullet extends Area2D

const bullet_scene : PackedScene = preload("res://Game/Bullet/bullet.tscn")

var speed : int				# bullet speed in pixels?
var lifetime : float		# lifetime of the bullet in seconds
var damage : float			# damage
var direction : Vector2		# bullet direction
var player_bullet : bool 	# true = player
var wavy_expression : Expression # expression to determine movement of bullet
var wavy_expression_args : Array # arguments used in expression
var speedy_expression : Expression # expression to determine speed changes of bullet
var speedy_expression_args : Array # arguments used in expression

func _ready() -> void:
	pass


## Add " + (sin(10 * $Lifetime.get_time_left()))" after 'rotation' to create a sin wave pattern
func _process(delta: float) -> void:	
	# modify the bullets motion based on the given expression
	var result_wavy = wavy_expression.execute(wavy_expression_args, self)
	if wavy_expression.has_execute_failed():
		print("wavy execute failed")
		
	var result_speedy = speedy_expression.execute(speedy_expression_args, self)
	if speedy_expression.has_execute_failed():
		print("speedy execute failed")
	else:
		position += Vector2.RIGHT.rotated(rotation + result_wavy) * (speed + result_speedy) * delta
	

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
	
	# create an empty expression as no expression was given
	bullet_instance.wavy_expression = Expression.new();
	bullet_instance.wavy_expression.parse("0")
	bullet_instance.wavy_expression_args = [];
	
	# create an empty expression as no expression was given
	bullet_instance.speedy_expression = Expression.new();
	bullet_instance.speedy_expression.parse("0")
	bullet_instance.speedy_expression_args = [];
	return bullet_instance
	
# new_bullet_wavy additionally needs an expression and an array of arguments for that expresstion
# the bullet's motion can be changed mid-flight using the given expression
@warning_ignore("shadowed_variable")
static func new_bullet_wavy(speed: int, direction: Vector2, lifetime: float, damage: float, player_bullet: bool, bullet_resource: ResourceBullet, wavy_expression : Expression, wavy_expression_args : Array) -> Bullet:
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
	
	bullet_instance.wavy_expression = wavy_expression
	bullet_instance.wavy_expression_args = wavy_expression_args
	
	# create an empty expression as no expression was given
	bullet_instance.speedy_expression = Expression.new();
	bullet_instance.speedy_expression.parse("0")
	bullet_instance.speedy_expression_args = [];
	return bullet_instance
	
@warning_ignore("shadowed_variable")
static func new_bullet_speedy(speed: int, direction: Vector2, lifetime: float, damage: float, player_bullet: bool, bullet_resource: ResourceBullet, speedy_expression : Expression, speedy_expression_args : Array) -> Bullet:
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
	
	bullet_instance.speedy_expression = speedy_expression
	bullet_instance.speedy_expression_args = speedy_expression_args
	
	# create an empty expression as no expression was given
	bullet_instance.wavy_expression = Expression.new();
	bullet_instance.wavy_expression.parse("0")
	bullet_instance.wavy_expression_args = [];
	
	return bullet_instance
	
@warning_ignore("shadowed_variable")
static func new_bullet_wavy_speedy(speed: int, direction: Vector2, lifetime: float, damage: float, player_bullet: bool, bullet_resource: ResourceBullet, wavy_expression : Expression, wavy_expression_args : Array, speedy_expression : Expression, speedy_expression_args : Array) -> Bullet:
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
	
	bullet_instance.speedy_expression = speedy_expression
	bullet_instance.speedy_expression_args = speedy_expression_args
	
	bullet_instance.wavy_expression = wavy_expression
	bullet_instance.wavy_expression_args = wavy_expression_args
	
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
