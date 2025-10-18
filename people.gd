extends Node2D

@onready var foule_1 = $Foule1
@onready var foule_2 = $Foule2
#@onready var foule_3 = $Foule3
#@onready var foule_4 = $Foule4

var amplitude = 7
var speed = 3.0
var base_y = {}

func _ready():
	for i in [foule_1, foule_2]:
		base_y[i] = i.position.y

func _process(delta):
	var time = Time.get_ticks_msec() / 1000.0
	foule_1.position.y = base_y[foule_1] + sin(time * speed) * amplitude
	foule_2.position.y = base_y[foule_2] + sin(time * speed + 0.5) * amplitude
	#foule_3.position.y = base_y[foule_3] + sin(time * speed + 1.0) * amplitude
	#foule_4.position.y = base_y[foule_4] + sin(time * speed + 1.5) * amplitude
