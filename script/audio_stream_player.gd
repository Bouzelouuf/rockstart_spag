extends Node2D

@onready var audio_player = $AudioStreamPlayer
var spectrum
var last_beat_time = 0.0
var detected_beats = []
var note_chart = []

var available_keys = ["left", "up", "down", "right"]
var last_key_index = 0

func _ready():
	var bus_index = AudioServer.get_bus_index("Master")
	spectrum = AudioServer.get_bus_effect_instance(bus_index, 0)
	audio_player.finished.connect(song_finished)
	audio_player.play()

func _process(delta):
	if spectrum != null:
		var bass_energy = spectrum.get_magnitude_for_frequency_range(20, 150).length()
		var current_time = audio_player.get_playback_position()
		if bass_energy > 0.025 and (current_time - last_beat_time) > 0.2:
			var key = available_keys[randi() % available_keys.size()]
			last_key_index = (last_key_index + 1) % available_keys.size()
			var note = {
				"time": current_time,
				"key": key
			}
			note_chart.append(note)
			last_beat_time = current_time

func song_finished():
	var song_name = audio_player.stream.resource_path.get_file().get_basename()
	var chart_path = "res://charts/" + song_name + "_chart.json"
	save_chart(chart_path)

func save_chart(path: String):
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(note_chart, "\t"))
		file.close()
	else:
		print("error file json pars song!!!!")
