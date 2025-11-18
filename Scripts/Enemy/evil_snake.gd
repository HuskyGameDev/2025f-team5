class_name EvilSnake extends EnemyBase
const enemy_snake_scene: PackedScene = preload("res://Game/Enemy/evil_snake.tscn")

var attacking : bool
var wavy_expression : Expression
var bullet_direction : int = 1
var speedy_expression : Expression
var speedy_expression_args : Array = []

func _ready() -> void:
	wavy_expression = Expression.new()
	wavy_expression.parse("sin(10 * find_child(\"Lifetime\").get_time_left()) * x", ["x"])
	speedy_expression = Expression.new()
	speedy_expression.parse("0")

@warning_ignore("shadowed_variable_base_class", "shadowed_variable")
static func new_enemy(_sprite: Sprite2D = null, health: float = 6.0, speed: int = 10, firerate: float = 2, damage: float = 1.0, shot_speed: int = 120, bullet_lifetime: float = 4.0) -> CharacterBody2D:
	var enemy_instance = enemy_snake_scene.instantiate()
	enemy_instance.health = health
	enemy_instance.speed = speed
	enemy_instance.firerate = firerate
	enemy_instance.shot_speed = shot_speed
	enemy_instance.bullet_lifetime = bullet_lifetime
	enemy_instance.damage = damage
	# enemy_instance.set_sprite(sprite)	# This will not work as Sprite2D cannot be a String
	enemy_instance.set_cooldown(firerate)
	return enemy_instance

# Currently using this to get the position of the player so the enemy can path to them
func find_player() -> Vector2:
	var player = get_tree().get_nodes_in_group("player")
	if len(player) > 0:
		return player[0].global_position
	else:
		return Vector2(0,0)
	

func _physics_process(delta: float) -> void:
	if(attacking):
		var player_direction = find_player() - global_position
		velocity = player_direction * speed * delta
		move_and_slide()
	

func _on_attack_cooldown_timeout() -> void:
	$Cooldown.stop()
	$Attacking.start()
	attacking = true
	
	get_tree().create_timer(2.5).timeout.connect(attack_over)
	

func attack_over() -> void:
	$Cooldown.start()
	$Attacking.stop()
	attacking = false
	

func _on_attacking_timeout() -> void:
	var bullet_instance = Bullet.new_bullet_wavy_speedy(shot_speed, get_tree().get_first_node_in_group("player").global_position, bullet_lifetime, damage, false, bullet_resource, wavy_expression, [bullet_direction], speedy_expression, speedy_expression_args)
	get_parent().add_child(bullet_instance)
	bullet_instance.position = position
	bullet_instance.fire()
	
	bullet_direction *= -1
