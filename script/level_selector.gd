extends Control

@onready var level1 = $VBoxContainer/song1
@onready var level2 = $VBoxContainer/song2
@onready var level3 = $VBoxContainer/song3
@onready var back = $VBoxContainer/back

func _ready():
	level1.pressed.connect(on_level1_pressed)
	level2.pressed.connect(on_level2_pressed)
	level3.pressed.connect(on_level3_pressed)
	back.pressed.connect(on_back_pressed)
	
func on_level1_pressed():
	SongManager.selected_song_id = "song1"
	get_tree().change_scene_to_file("res://scene/main_scene.tscn")

func on_level2_pressed():
	SongManager.selected_song_id = "song2"
	get_tree().change_scene_to_file("res://scene/main_scene.tscn")

func on_level3_pressed():
	SongManager.selected_song_id = "song3"
	get_tree().change_scene_to_file("res://scene/main_scene.tscn")

func on_back_pressed():
	get_tree().change_scene_to_file("res://scene/menu.tscn")
