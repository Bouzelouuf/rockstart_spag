extends Control

@onready var retry_button = $VBoxContainer/retry_button
@onready var resume_score_label = $VBoxContainer/resume_score_label
@onready var exit_button = $VBoxContainer/exit_button

func _ready():
	retry_button.pressed.connect(on_retry_pressed)
	exit_button.pressed.connect(on_exit_pressed)

func display_score(score: float, stats: Dictionary, combo: int):
	var total = stats["total_notes"]
	if total == 0:
		total = 1

	var hit_notes = stats["perfect"] + stats["good"] + stats["ok"]
	var accuracy = (hit_notes * 100.0 / total) if total > 0 else 0

	var text = ""
	text += "=== LEVEL COMPLETE ===\n\n"
	text += "Score: " + str(int(score)) + "\n\n"
	text += "Perfect: " + str(stats["perfect"]) + "\n"
	text += "Good: " + str(stats["good"]) + "\n"
	text += "OK: " + str(stats["ok"]) + "\n"
	text += "Late: " + str(stats["late"]) + "\n"
	text += "Miss: " + str(stats["miss"]) + "\n\n"
	resume_score_label.text = text

func on_retry_pressed():
	get_tree().change_scene_to_file("res://scene/main_scene.tscn")

func on_exit_pressed():
	get_tree().quit()
