extends Node2D

var keyName: String
var speed: float
var expected_beat_time: float = 0.0
var screenSize: Vector2
#signal bye

func _init() -> void:
	set_process(false)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screenSize = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if global_position.y > screenSize.y + 50:
		queue_free()
	
	position.y += speed * delta
