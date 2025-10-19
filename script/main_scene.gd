extends Node2D

@onready var music_player = $MusicPlayer
@onready var player_particles = $AnimatedSprite2D/GPUParticles2D
@onready var player_particles2 = $AnimatedSprite2D/GPUParticles2D2

var note_chart = []
var current_note_index = 0
var fall_duration = 0.0
var game_start_time = 0.0
var start_delay = 0.0
var elapsed_time = 0.0
var started = false

@onready var key_landers = {
	"left": $LeftLander,
	"right": $RightLander,
	"up": $UpLander,
	"down": $DownLander
}

func _ready():
	player_particles2.visible = false
	player_particles.visible = false
	var song = SongManager.set_current_song("song3")
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
		fall_duration = first_lander.keyScreenTime
	var first_beat = note_chart[0]["time"] if note_chart.size() > 0 else 0.0
	var delay_needed = max(0, fall_duration - first_beat)
	game_start_time = Time.get_ticks_msec() / 1000.0
	start_delay = delay_needed
	#if delay_needed > 0:
		#await get_tree().create_timer(delay_needed).timeout


func _physics_process(delta: float) -> void:
	elapsed_time += delta
	#print("ELAPSED_TIME: ", elapsed_time)
	#print("START_DELAY: ", start_delay)
	if elapsed_time >= start_delay and not started:
		started = true
		music_player.play()
	# if started:
	var music_time = music_player.get_playback_position() + AudioServer.get_time_since_last_mix()
	music_time -= AudioServer.get_output_latency()
	if music_time == null or music_time < 0:
		return
	while current_note_index < note_chart.size():
		#print(current_note_index)
		var note = note_chart[current_note_index]
		var beat_time = note["time"]
		var spawn_time = beat_time - fall_duration + start_delay
		#var actual_spawn_time = max(0, spawn_time)
		if music_time >= spawn_time:
			spawn_note(note)
			print("ELAPSED_TIME: ", elapsed_time)
			print("MUSIC_TIME: ", music_time)
			print("ACTUAL_SPAWN_TIME: ", spawn_time)
			current_note_index += 1
		else:
			break

func spawn_note(note: Dictionary):
	var key_direction = note["key"]
	var beat_time = note["time"]
	
	if key_landers.has(key_direction):
		var key_lander = key_landers[key_direction]
		key_lander.spawn_key(beat_time)


func _on_down_lander_score_up(addendum: int) -> void:
	pass # Replace with function body.


func _on_up_lander_score_up(addendum: int) -> void:
	pass # Replace with function body.
