extends Node2D

@onready var music_player = $MusicPlayer
@onready var player_particles = $AnimatedSprite2D/GPUParticles2D
@onready var player_particles2 = $AnimatedSprite2D/GPUParticles2D2

var note_chart = []
var current_note_index = 0
var fall_duration = 0.0
var game_start_time = 0.0

@onready var key_landers = {
	"left": $LeftLander,
	"right": $RightLander,
	"up": $UpLander,
	"down": $DownLander
}

func _ready():
	player_particles2.visible = false
	player_particles.visible = false
	var song = SongManager.set_current_song("song1")
	for key_lander in key_landers.values():
		key_lander.scoreUp.connect(on_score_up)
		
	if song:
		load_music(song["music"])
		load_chart(song["chart"])
		start_game()

func on_score_up(score: int):
	if score >= 100:
		player_particles2.restart()
		player_particles.restart()
		player_particles2.visible = true
		player_particles.visible = true
		#player_particles.visible
		#player_particles2.visible
		await get_tree().create_timer(3.0).timeout
		player_particles2.visible = false
		player_particles.visible = false

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
	if key_landers.size() > 0:
		var first_lander = key_landers.values()[0]
		fall_duration = first_lander.calculate_fall_duration()
	var first_beat = note_chart[0]["time"] if note_chart.size() > 0 else 0.0
	var delay_needed = max(0, fall_duration - first_beat)
	game_start_time = Time.get_ticks_msec() / 1000.0
	if delay_needed > 0:
		await get_tree().create_timer(delay_needed).timeout
	music_player.play()

func _process(delta):
	if not music_player.playing:
		return
	var music_time = music_player.get_playback_position()
	if music_time == null or music_time < 0:
		return
	while current_note_index < note_chart.size():
		var note = note_chart[current_note_index]
		var beat_time = note["time"]
		var spawn_time = beat_time - fall_duration
		var actual_spawn_time = max(0, spawn_time)
		if music_time >= actual_spawn_time:
			spawn_note(note)
			current_note_index += 1
		else:
			break

func spawn_note(note: Dictionary):
	var key_direction = note["key"]
	var beat_time = note["time"]
	
	if key_landers.has(key_direction):
		var key_lander = key_landers[key_direction]
		key_lander.spawn_key(beat_time)
