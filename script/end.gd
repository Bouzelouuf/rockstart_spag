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
	text += "=== LEVEL COMPLETE ===\n"
	text += "Score: %d\n" % int(score)
	text += "Perfect: %d (%.1f%%)\n" % [stats["perfect"], stats["perfect"] * 100.0 / total]
	text += "Good: %d (%.1f%%)\n" % [stats["good"], stats["good"] * 100.0 / total]
	text += "OK: %d (%.1f%%)\n" % [stats["ok"], stats["ok"] * 100.0 / total]
	text += "Late: %d (%.1f%%)\n" % [stats["late"], stats["late"] * 100.0 / total]
	text += "Miss: %d (%.1f%%)\n" % [stats["miss"], stats["miss"] * 100.0 / total]
	text += "======================\n"
	text += "Max Combo: %d\n" % combo
	text += "Accuracy: %.1f%%" % accuracy
	resume_score_label.text = text

func on_retry_pressed():
	get_tree().change_scene_to_file("res://scene/main_scene.tscn")

func on_exit_pressed():
	get_tree().quit()
