extends CharacterBody2D

@export var health : int = 5
@export var speed : int = 200
@export var shootspeed : int = 200
@export var shoot_range : float = 2.0
@export var damage : int = 10
@export var firerate : float = 0.5

var can_move = true
var can_dash = true
var can_shoot = true

# Handles moving the character around
func _physics_process(delta: float) -> void:	
	if can_move:
		# get the input direction and handle the movement/deceleration.
		# moving left or right
		var input_direction := Input.get_vector("Left", "Right", "Up", "Down")
		velocity = input_direction * speed
		
		# dashing
		if Input.is_action_pressed("Dash") && can_dash:
			can_move = false;
			velocity = velocity * 4
			
			# set times for a dash duration and dash cooldown
			get_tree().create_timer(0.15).timeout.connect(end_dash)
			get_tree().create_timer(0.5).timeout.connect(dash_reset)
			can_dash = false;
		
	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_pressed("PrimaryAction") && can_shoot && health > 0:
		var shot = Bullet.new_bullet(shootspeed, get_global_mouse_position(), shoot_range, damage, true)
		get_parent().add_child(shot)
		shot.position = self.position
		shot.fire()
		can_shoot = false
		get_tree().create_timer(firerate).timeout.connect(shot_reset)


# Called when a dash ends, allows the player to control movement again
func end_dash():
	can_move = true;
	
# Called when dash cooldown ends, allows the player to dash again
func dash_reset():
	can_dash = true
	
# Basic take damage function
func take_damage():
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
