extends CharacterBody2D

@export var health : int = 5				# Health of player
@export var speed : int = 200			# Speed of player
@export var shot_speed : int = 200		# Speed of bullets
@export var bullet_lifetime : float = 2.0	# Lifetime of bullets
@export var damage : float = 10.0		#
@export var firerate : float = 0.5
var reversed = false		# orientation, false = normal, true = reversed
var bullet_type: String = "default"

var dna_name = []
var dna_count = []
signal dna_levelup(type)

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
		var shot = Bullet.new_bullet(shot_speed, get_global_mouse_position(), bullet_lifetime, damage, true, Globals.bullet_types[bullet_type]["sprite"], Globals.bullet_types[bullet_type]["collision_body"])
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

func gain_dna(dna_type: String, quantity: int):
	var index = dna_name.find(dna_type)
	if index == -1:
		dna_name.push_back(dna_type)
		index = dna_name.size() - 1
		dna_count.push_back(0)
	dna_count[index] += quantity
	if dna_count[index] >= Globals.dna_types[dna_name[index]]["rarity"]:
		dna_levelup.emit(dna_type)
		dna_count[index] -= Globals.dna_types[dna_name[index]]["rarity"]
	pass

# Handles changes caused by a dna upgrade
func dna_changes(dna_type: String, effect_type: String):
	match effect_type:
		"all":
			health += Globals.dna_types[dna_type]["health"]
			speed += Globals.dna_types[dna_type]["speed"]
			shot_speed += Globals.dna_types[dna_type]["shot_speed"]
			bullet_lifetime += Globals.dna_types[dna_type]["bullet_lifetime"]
			damage += Globals.dna_types[dna_type]["damage"]
			health += Globals.dna_types[dna_type]["health"]
			firerate += Globals.dna_types[dna_type]["firerate"]
			bullet_type = Globals.dna_types[dna_type]["bullet"]
		"movement":
			pass
		"shooting":
			pass
