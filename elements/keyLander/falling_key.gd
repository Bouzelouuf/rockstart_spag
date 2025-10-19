extends Node2D

var keyName: String
var speed: int
var expected_beat_time: float = 0.0
#signal bye

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if global_position.y > get_viewport_rect().size.y + 50:
		queue_free()
	
	position.y += speed * delta
