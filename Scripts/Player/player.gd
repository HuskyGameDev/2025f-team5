extends CharacterBody2D

@onready var max_health: int = Globals.player_base["health"]
@onready var health : int =  Globals.player_base["health"]
@onready var speed : int = Globals.player_base["speed"]
@onready var shot_speed : int = Globals.player_base["shot_speed"]
@onready var bullet_lifetime : float = Globals.player_base["bullet_lifetime"]
@onready var damage : float = Globals.player_base["damage"]
@onready var firerate : float = Globals.player_base["firerate"]
var reversed = false		# orientation, false = normal, true = reversed
@export var bullet_type: ResourceBullet

var can_move : bool = true
var can_dash : bool = true
var can_shoot : bool = true
var is_dashing : bool = false
var is_alive : bool = true

# Handles moving the character around
func _physics_process(_delta: float) -> void:	
	# player is dead and can't do anything
	if(!is_alive):
		return
	
	if can_move:
		# get the input direction and handle the movement/deceleration.
		# moving left or right
		var input_direction := Input.get_vector("Left", "Right", "Up", "Down")
		velocity = input_direction * speed
		
		# dashing
		if Input.is_action_pressed("Dash") && can_dash && (velocity.x + velocity.y) != 0:
			can_move = false
			velocity = velocity * 4
			
			# set times for a dash duration and dash cooldown
			get_tree().create_timer(0.15).timeout.connect(end_dash)
			get_tree().create_timer(0.5).timeout.connect(dash_reset)
			can_dash = false
			is_dashing = true
		
	move_and_slide()

func _process(_delta: float) -> void:
	# player is dead and can't do anything
	if(!is_alive):
		return
	
	# evil scuffed flip code
	var mouse_position = get_global_mouse_position() 
	if (mouse_position.x > global_position.x) && reversed:
		scale.x = -scale.x
		reversed = false
	elif (mouse_position.x < global_position.x) && !reversed:
		scale.x = -scale.x
		reversed = true  
	
	if Input.is_action_pressed("PrimaryAction") && can_shoot && health > 0:
		var shot = Bullet.new_bullet(shot_speed, get_global_mouse_position(), bullet_lifetime, damage, true, bullet_type)
		get_parent().add_child(shot)
		shot.global_position = self.get_node("PlayerGun/BulletExitPoint").global_position
		shot.fire()
		can_shoot = false
		get_tree().create_timer(firerate).timeout.connect(shot_reset)


# Called when a dash ends, allows the player to control movement again
func end_dash():
	can_move = true
	is_dashing = false
	
# Called when dash cooldown ends, allows the player to dash again
func dash_reset():
	can_dash = true
	
# Basic take damage function
func hit():
	if(!is_dashing):
		health -= 1
		$/root/Main/CanvasLayer/UI/HealthBar.update_health(health)
	
	# when player dies, change to the dead sprite
	if health == 0:
		die()
		
		
func die() -> void:
	can_move = false
	can_shoot = false
	velocity = velocity * 0
	$AliveSprite.visible = not $AliveSprite.visible
	$DeadSprite.visible = not $DeadSprite.visible
	is_alive = false

func shot_reset():
	can_shoot = true

func reset_stats():
	health =  Globals.player_base["health"]
	speed = Globals.player_base["speed"]
	shot_speed = Globals.player_base["shot_speed"]
	bullet_lifetime = Globals.player_base["bullet_lifetime"]
	damage = Globals.player_base["damage"]
	firerate = Globals.player_base["firerate"]

func update_stats(update):
	update_health(update["health"])
	speed = update["speed"] if update["speed"] > Globals.player_min["speed"] else Globals.player_min["speed"]
	shot_speed = update["shot_speed"] if update["shot_speed"] > Globals.player_min["shot_speed"] else Globals.player_min["shot_speed"]
	bullet_lifetime = update["bullet_lifetime"] if update["bullet_lifetime"] > Globals.player_min["bullet_lifetime"] else Globals.player_min["bullet_lifetime"]
	damage = update["damage"] if update["damage"] > Globals.player_min["damage"] else Globals.player_min["damage"]
	firerate = update["firerate"] if update["firerate"] > Globals.player_min["firerate"] else Globals.player_min["firerate"]
	if update["bullet"] != null:
		bullet_type = update["bullet"]

func update_health(new_max: int):
	var old_max : int = max_health
	max_health = new_max if new_max > Globals.player_min["health"] else Globals.player_min["health"]
	
	if max_health > old_max: 
		var difference : int = max_health - old_max
		health = max_health if (health == old_max) else health + difference
	elif max_health < old_max:
		health = max_health if (health >= max_health) else health
	
	$/root/Main/CanvasLayer/UI/HealthBar.update_health(health)
