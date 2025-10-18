extends Area2D

@export var key_str: String
@export var key_rotation: int = 0
@export var scoreThresholds: Array[int]
var keySpeed: int = 100
var keyFile: PackedScene = preload("./fallingKey.tscn")
var screenSize: Vector2
var collisionRadius: float
#var keyArr: Array[Node2D]

signal scoreUp(addendum: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collisionRadius = $CollisionShape2D.shape.radius * $CollisionShape2D.scale.x
	print("COLL_RAD: ", collisionRadius)
	screenSize = get_viewport_rect().size
	spawn_key()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed(key_str):
		var dist = INF
		if len(get_overlapping_areas()):
			for key in get_overlapping_areas():
				#dist = 
				if key.position.x > scoreThresholds[0]:
					print("EARLY")
				elif key.position.x > scoreThresholds[1]:
					print("PERFECT")
				else:
					print("LATE")
		else:
			print("MISS")


func spawn_key():
	var key = keyFile.instantiate()
	add_child(key)
	#keyArr.append(key)
	key.speed = keySpeed
	key.keyName = key_str
	key.position.x = screenSize.x - position.x
	key.rotation_degrees = key_rotation
	#key.bye.connect(pop_key)


#func pop_key():
	#keyArr.pop_front()
