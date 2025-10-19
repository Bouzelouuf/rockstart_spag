extends Control

@onready var play_button = $VBoxContainer/play_button
@onready var exit_button = $VBoxContainer/exit_button
@onready var level_button = $VBoxContainer/level_button

func _ready():
	play_button.pressed.connect(play_pressed)
	exit_button.pressed.connect(exit_pressed)
	level_button.pressed.connect(level_pressed)
	
func level_pressed():
	get_tree().change_scene_to_file("res://scene/level_selector.tscn")

func play_pressed():
	get_tree().change_scene_to_file("res://scene//main_scene.tscn")

func exit_pressed():
	get_tree().quit()
