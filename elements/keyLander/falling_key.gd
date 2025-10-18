extends Node2D

var keyName: String
var speed: int

#signal bye

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if global_position.x < 0:
		print("FREED %s" % keyName)
		#bye.emit()
		queue_free()
	
	position.x -= speed * delta
