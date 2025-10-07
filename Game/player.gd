extends CharacterBody2D

@export var health = 5
@export var speed = 200
var can_move = true
var can_dash = true

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
		can_move = false;
		$AliveSprite.visible = not $AliveSprite.visible
		$DeadSprite.visible = not $DeadSprite.visible
