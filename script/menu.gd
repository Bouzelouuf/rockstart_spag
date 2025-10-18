extends Control

@onready var play_button = $VBoxContainer/play_button
@onready var exit_button = $VBoxContainer/exit_button

func _ready():
	play_button.pressed.connect(play_pressed)
	exit_button.pressed.connect(exit_pressed)
	
func play_pressed():
	get_tree().change_scene_to_file("res://scene//main_scene.tscn")

func exit_pressed():
	get_tree().quit()
