extends CanvasLayer

var total_score: int = 0
@onready var score_label = $ScoreLabel
@onready var combo_label = $ComboLabel

func add_score(point: int):
	total_score += point
	score_label.text = "Score:" + str(total_score)

func add_combo(combo: int):
	combo_label.text = "X" + str(combo)
	
func _on_right_lander_score_up(addendum: int) -> void:
	add_score(addendum)


func _on_left_lander_score_up(addendum: int) -> void:
	add_score(addendum)


func _on_up_lander_score_up(addendum: int) -> void:
	add_score(addendum)


func _on_down_lander_score_up(addendum: int) -> void:
	add_score(addendum)


func _on_left_lander_combo_up(addendum: int) -> void:
	add_combo(addendum)

func _on_right_lander_combo_up(addendum: int) -> void:
	add_combo(addendum)


func _on_down_lander_combo_up(addendum: int) -> void:
	add_combo(addendum)


func _on_up_lander_combo_up(addendum: int) -> void:
	add_combo(addendum)
