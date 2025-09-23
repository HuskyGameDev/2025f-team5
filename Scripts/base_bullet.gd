extends Area2D

@export var speed : int = 200			# bullet speed in pixels?
@export var lifetime : float = 1.0		# lifetime of the bullet in seconds

func _ready() -> void:
	look_at(get_global_mouse_position())
	despawn()

func _process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta


func despawn() -> void:
	await get_tree().create_timer(lifetime).timeout
	queue_free()
	
