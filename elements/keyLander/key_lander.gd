extends Area2D

@export var key_str: String
@export var key_rotation: int = 0
@export var scoreThresholds: Array[int] = [50, 30, 10]
var keySpeed: int = 180
var keyFile: PackedScene = preload("res://elements/keyLander/fallingKey.tscn")
var screenSize: Vector2
var collisionRadius: float

signal scoreUp(addendum: int)

func _ready() -> void:
	screenSize = get_viewport_rect().size
	if has_node("CollisionShape2D"):
		collisionRadius = $CollisionShape2D.shape.radius * $CollisionShape2D.scale.x

func _physics_process(delta: float) -> void:
	if not InputMap.has_action(key_str):
		return
	if Input.is_action_just_pressed(key_str):
		var overlapping = get_overlapping_areas()
		if overlapping.size() > 0:
			for key in overlapping:
				var distance = key.global_position.distance_to(global_position)
				if distance < 30:
					scoreUp.emit(100)
				elif distance < 60:
					scoreUp.emit(50)
				elif distance < 100:
					scoreUp.emit(25)
				key.queue_free()

func spawn_key(beat_time: float = 0.0):
	var key = keyFile.instantiate()
	get_parent().add_child(key)
	
	key.speed = keySpeed
	key.keyName = key_str
	key.expected_beat_time = beat_time
	key.global_position = Vector2(global_position.x, -50)
	key.rotation_degrees = key_rotation

func calculate_fall_duration() -> float:
	var spawn_y = -50.0
	var target_y = global_position.y
	var distance = target_y - spawn_y
	return distance / keySpeed
