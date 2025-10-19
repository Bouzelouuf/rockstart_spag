extends CanvasLayer

@onready var pause_panel = $Panel

func _ready():
	hide()
	process_mode = Node
