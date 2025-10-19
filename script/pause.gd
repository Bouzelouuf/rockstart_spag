extends Control

@onready var resume_button = $VBoxContainer/resume_button
@onready var retry_button = $VBoxContainer/retry_button
@onready var exit_button = $VBoxContainer/exit_button

func _ready():
	resume_button.pressed.connect(resume_pressed)
	retry_button.pressed.connect(retry_pressed)
	exit_button.pressed.connect(exit_pressed)
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	visible = !visible
	get_tree().paused = visible
	if visible:
		print("game pause")
	else:
		print("game continue")
		
func resume_pressed():
	toggle_pause()


func retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func exit_pressed():
	#get_tree().quit()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/menu.tscn")


func _on_left_lander_combo_up(addendum: int) -> void:
	pass # Replace with function body.
