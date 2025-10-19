extends Area2D

@export var key_str: String
@export var key_rotation: int = 0
@export var keyScreenTime: float = 3.5
@export var scoreThresholds: Array[int]

@onready var visual = $Sprite2D
@onready var judgement_label = $Label
var original_visual_position: Vector2

var keyFile: PackedScene = preload("./fallingKey.tscn")
var screenSize: Vector2
var collisionRadius: float

signal scoreUp(addendum: int)

var current_combo = 0
signal comboUp(addendum: int)
var max_combo = 33
var total_score = 0


var shake_offset = Vector2.ZERO


func _ready() -> void:
	original_visual_position = visual.position
	screenSize = get_viewport_rect().size
	if has_node("CollisionShape2D"):
		collisionRadius = $CollisionShape2D.shape.radius * $CollisionShape2D.scale.x

func _process(delta):
	visual.position = original_visual_position + shake_offset

func _physics_process(delta: float) -> void:
	if not InputMap.has_action(key_str):
		return
	if Input.is_action_just_pressed(key_str):
		var overlapping = get_overlapping_areas()
		if overlapping.size() > 0:
			for key in overlapping:
				var points = 0
				var text
				var color = Color.WHITE
				var offset = abs(key.global_position.y - global_position.y)
				if offset < 10:
					text = "PERFECT"
					color = Color.GREEN
					points = 100
					increment_combo()
				elif offset < 20:
					text = "GOOD"
					color = Color.ORANGE
					points = 50
					increment_combo()
				elif offset < 30:
					text = "OK"
					color = Color.YELLOW
					points = 20
					increment_combo()
				else:
					color = Color.RED
					text = "LATE"
					shake_zone()
					reset_combo()
				flash_color(color)
				#increment_combo()
				add_score(points)
				show_judgment(text,color)
				key.queue_free()
				break
		else:
			flash_color(Color.RED)
			show_judgment("MISS", Color.RED)
			reset_combo()
			shake_zone()

func add_score(base_points: int):
	var multiplier = 1.0 +(current_combo / 10.0)
	var points = base_points * multiplier
	total_score += points
	scoreUp.emit(total_score)


func increment_combo():
	current_combo += 1
	max_combo = max(max_combo, current_combo)
	comboUp.emit(current_combo)
	
func reset_combo():
	if current_combo > 0:
		current_combo = 0
		comboUp.emit(current_combo)
func combo_multi():
	pass

func show_judgment(text: String, color: Color):
	var rad = [-25, 25]
	judgement_label.rotation = rad[randi() % rad.size()]
	judgement_label.text = text
	judgement_label.modulate = color
	judgement_label.modulate.a = 1.0
	judgement_label.scale = Vector2(0.5, 0.5)

func flash_color(color: Color):
	var tween = create_tween()
	tween.tween_property(visual, "self_modulate", color, 0.1)
	tween.tween_interval(0.5)
	tween.tween_property(visual, "self_modulate", Color.WHITE, 0.4)

func shake_zone():
	#var original_pos = visual.position
	var tween = create_tween()
	tween.tween_property(self, "shake_offset:x", 10.0, 0.05)
	tween.tween_property(self,  "shake_offset:x", -10.0, 0.05)
	tween.tween_property(self,  "shake_offset:x", 0.0, 0.05)

func spawn_key(beat_time: float = 0.0):
	var key = keyFile.instantiate()
	get_parent().add_child(key)
	
	key.speed = keySpeed
	key.keyName = key_str
	key.global_position.y = -50
	key.rotation_degrees = key_rotation
	print("BEAT_TIME: ", beat_time)
	key.speed = key.position.distance_to(Vector2(0,0)) / keyScreenTime
	#key.bye.connect(pop_key)

func calculate_fall_duration() -> float:
	var spawn_y = -50.0
	var target_y = global_position.y
	var distance = target_y - spawn_y
	return distance / keySpeed
