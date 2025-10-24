extends CharacterBody2D

@export var health : int = 5				# Health of player
@export var speed : int = 200			# Speed of player
@export var shot_speed : int = 200		# Speed of bullets
@export var bullet_lifetime : float = 2.0	# Lifetime of bullets
@export var damage : float = 10.0		#
@export var firerate : float = 0.5
var reversed = false		# orientation, false = normal, true = reversed

var can_move = true
var can_dash = true
var can_shoot = true

# Handles moving the character around
func _physics_process(_delta: float) -> void:	
	if can_move:
		# get the input direction and handle the movement/deceleration.
		# moving left or right
		var input_direction := Input.get_vector("Left", "Right", "Up", "Down")
		velocity = input_direction * speed
		
		# dashing
		if Input.is_action_pressed("Dash") && can_dash:
			can_move = false
			velocity = velocity * 4
			
			# set times for a dash duration and dash cooldown
			get_tree().create_timer(0.15).timeout.connect(end_dash)
			get_tree().create_timer(0.5).timeout.connect(dash_reset)
			can_dash = false
		
	move_and_slide()

func _process(_delta: float) -> void:
	# evil scuffed flip code
	var mouse_position = get_global_mouse_position() 
	if (mouse_position.x > global_position.x) && reversed:
		scale.x = -scale.x
		reversed = false
	elif (mouse_position.x < global_position.x) && !reversed:
		scale.x = -scale.x
		reversed = true  
	
	if Input.is_action_pressed("PrimaryAction") && can_shoot && health > 0:
		var shot = Bullet.new_bullet(shot_speed, get_global_mouse_position(), bullet_lifetime, damage, true, Globals.bullet_types["default"]["sprite"], Globals.bullet_types["default"]["collision_body"])
		get_parent().add_child(shot)
		shot.global_position = self.get_node("PlayerGun/BulletExitPoint").global_position
		shot.fire()
		can_shoot = false
		get_tree().create_timer(firerate).timeout.connect(shot_reset)


# Called when a dash ends, allows the player to control movement again
func end_dash():
	can_move = true
	
# Called when dash cooldown ends, allows the player to dash again
func dash_reset():
	can_dash = true
	
# Basic take damage function
func hit():
	health -= 1
	
	# when player dies, change to the dead sprite
	if health == 0:
		die()
		
		
func die() -> void:
	can_move = false
	can_shoot = false
	$AliveSprite.visible = not $AliveSprite.visible
	$DeadSprite.visible = not $DeadSprite.visible
	

func shot_reset():
	can_shoot = true
