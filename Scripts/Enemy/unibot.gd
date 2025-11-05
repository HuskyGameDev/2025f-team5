class_name Unibot extends EnemyBase
const enemy_unibot_scene: PackedScene = preload("res://Game/Enemy/unibot.tscn")

var attack_duration : float # how long the enemy attacks for
var attacking : bool # determines if the enemy is ready to shoot or not
var player_position : Vector2 # the position of the player when an attack is started
var reversed : bool = false # determines whether the sprite is flipped or not

	# starts attack pattern when the attack cooldown ends
func _on_attack_cooldown_timeout() -> void:
	$Cooldown.set_paused(true)
	$Attacking.set_paused(false)
	set_animation("moveAndChargeForwards")
	get_tree().create_timer(attack_duration).timeout.connect(attack_over)
	player_position = get_tree().get_first_node_in_group("player").position
	
	# determine whether to move vertically or horizontally
	var direction = randi() % 2
	if(direction == 0):
		velocity.x = speed
		velocity.y = 0
		# ensure the bot moves towards the player initially
		if(position.x > player_position.x):
			velocity.x *= -1
	else:
		velocity.y = speed
		velocity.x = 0
		# ensure the bot moves towards the player initially
		if(position.y > player_position.y):
			velocity.y *= -1
	
	

	# shoots a bullet 
func _on_attacking_timeout() -> void:
	if(attacking):
		var bullet_direction : Vector2 
		bullet_direction.x = abs(velocity.y)
		bullet_direction.y = abs(velocity.x)
		var bullet_instance = Bullet.new_bullet(shot_speed, bullet_direction, bullet_lifetime, damage, false, bullet_resource)
		get_parent().add_child(bullet_instance)
		bullet_instance.position = position
		bullet_instance.fire()
		
	

	# resets to idle state after attack
func attack_over() -> void:
	$Cooldown.set_paused(false)
	$Attacking.set_paused(true)
	$EnemyAnimation.play("idle", 1, false)
	attacking = false
	

	# sets animation to given animation
func set_animation(animation: String) -> void:
	$EnemyAnimation.play(animation, 1, false)
	

	# Creates and returns a new enemy instance
@warning_ignore("shadowed_variable_base_class", "shadowed_variable")
static func new_enemy(_sprite: Sprite2D = null, health: float = 5.0, speed: int = 250, firerate: float = 2.0, damage: float = 1.0, shot_speed: int = 200, bullet_lifetime: float = 2.0, attack_duration: float = 3.0) -> CharacterBody2D:
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
	$Attacking.set_paused(true)

	# sets the animation from charging to shooting after the charging animation completes
func _on_enemy_animation_animation_looped() -> void:
	if($EnemyAnimation.get_animation() == "moveAndChargeForwards"):
		set_animation("moveAndShootForwards")
		attacking = true
	elif($EnemyAnimation.get_animation() == "moveAndChargeBackwards"):
		set_animation("moveAndShootBackwards")
		attacking = true

func _physics_process(_delta: float) -> void:
	# move the unibot
	if(attacking):
		# reverse movement direction if it hits a wall
		if(move_and_slide()):
			velocity.x *= -1
			velocity.y *= -1
	
	# evil scuffed flip code, only flips when not attacking
	if(!attacking):
		if (get_tree().get_first_node_in_group("player").position.x < position.x) && reversed:
			scale.x = -scale.x
			reversed = false
		elif (get_tree().get_first_node_in_group("player").position.x > position.x) && !reversed:
			scale.x = -scale.x
			reversed = true  
	
