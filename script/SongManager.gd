extends Node

var songs_data = {}
var current_song = null

func _ready():
	load_songs_config()

func load_songs_config():
	var file = FileAccess.open("res://songs_config.json", FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		var json = JSON.parse_string(json_text)
		file.close()
		if json and json.has("songs"):
			for song in json["songs"]:
				songs_data[song["id"]] = song
		else:
			print("error format json nonvalid")
	else:
		print("error file song not found")

func get_song(song_id: String):
	if songs_data.has(song_id):
		return songs_data[song_id]
	else:
	#	print("song not found:", current_song["name"])
		return null

func get_all_songs():
	return songs_data.values()

func set_current_song(song_id: String):
	current_song = get_song(song_id)
	if current_song:
		print("current song tuto apposto! song :", current_song["name"])
	return current_song
