extends Node2D

@onready var music_player = $MusicPlayer

var note_chart = []
var current_note_index = 0
var fall_duration = 6.4
var countdown_duration = 3.0
var game_start_time = 0.0
var music_start_time = 0.0

@onready var key_landers = {
	"left": $LeftLander,
	"right": $RightLander,
	"up": $UpLander,
	"down": $DownLander
}

func _ready():
	var song = SongManager.set_current_song("song1")
	
	if song:
		load_music(song["music"])
		load_chart(song["chart"])
		start_game()

func load_music(music_path: String):
	var music_stream = load(music_path)
	if music_stream:
		music_player.stream = music_stream

func load_chart(chart_path: String):
	var file = FileAccess.open(chart_path, FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		note_chart = JSON.parse_string(json_text)
		file.close()

func start_game():	
	game_start_time = Time.get_ticks_msec() / 1000.0
	music_start_time = game_start_time + countdown_duration
	show_countdown()
	await get_tree().create_timer(countdown_duration).timeout
	music_player.play()

func show_countdown():
	# TODO: Afficher "3... 2... 1... GO!" à l'écran
	pass

func _process(delta):
	var current_time = Time.get_ticks_msec() / 1000.0
	var elapsed_time = current_time - game_start_time
	
	var music_time = elapsed_time - countdown_duration
	
	while current_note_index < note_chart.size():
		var note = note_chart[current_note_index]
		var note_beat_time = note["time"]
		var note_spawn_time = note_beat_time - fall_duration
		
		if music_time >= note_spawn_time:
			spawn_note(note)
			current_note_index += 1
		else:
			break

func spawn_note(note: Dictionary):
	var key_direction = note["key"]
	
	if key_landers.has(key_direction):
		var key_lander = key_landers[key_direction]
		key_lander.spawn_key()
