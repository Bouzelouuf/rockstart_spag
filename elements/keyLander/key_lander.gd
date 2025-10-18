extends Node2D

@export var key_str: String

var keyFile: PackedScene = preload("./fallingKey.tscn")
var key

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	key = keyFile.instantiate()
	add_child(key)
	key.position.x = 500


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed(key_str):
		if key.position.x < 0:
			print("LATE")
		elif key.position.x > 0:
			print("EARLY")
		else:
			print("PERFECT")
