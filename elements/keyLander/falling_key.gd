extends Node2D

var keyName: String
var speed: float

#signal bye

func _init() -> void:
	set_process(false)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if global_position.x < 0:
		print("FREED %s" % keyName)
		#bye.emit()
		queue_free()
	
	position.x -= speed * delta
