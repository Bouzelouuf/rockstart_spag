extends Node2D

@onready var music_player = $MusicPlayer

var note_chart = []
var current_note_index = 0

func _ready():
	var song = SongManager.set_current_song("song1")
	
	if song:
		print("Nom : ", song["name"])
		print("Musique : ", song["music"])
		print("Chart : ", song["chart"])
		
		load_music(song["music"])
		load_chart(song["chart"])
		start_game()
func load_music(music_path: String):
	var music_stream = load(music_path)
	if music_stream:
		music_player.stream = music_stream
	else:
		print("error for load song : ",music_path)
		
func load_chart(char_path: String):
	var file = FileAccess.open(char_path, FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		note_chart = JSON.parse_string(json_text)
		file.close()
	else:
		print("errore , char not found")
func start_game():
	print("🎮 Démarrage du jeu !")
	music_player.play()
	print("🔊 Position de lecture : ", music_player.get_playback_position())
	print("🔊 Est en train de jouer ? ", music_player.playing)
	current_note_index = 0
	
