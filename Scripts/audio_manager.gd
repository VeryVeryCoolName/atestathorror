extends Node
var streamplayer: AudioStreamPlayer
var sfx_player: AudioStreamPlayer
var current_stream: AudioStream = null
var nopause_sfx_volume_db: float = 6.0
var music_list = {
	"game": preload("res://Music/music_before_boss.wav"),
	"menu": preload("res://Music/mainmeniu.mp3"),
	"phase1": preload("res://Music/phase_1_music.wav"),
	"phase2": preload("res://Music/phase_2_music.wav")
}
var sfx_list = { 
	"jingle": preload("res://Music/sfx/jingle.mp3"),
	"pause": preload("res://Music/sfx/pause.wav"),
	"unpause": preload("res://Music/sfx/unpause.wav"),
	"howl": preload("res://Music/sfx/ambient_sound_before_fight.mp3"),
	"attack_hit": preload("res://Music/sfx/attack_hit_sound.mp3"),
	"attack_boss": preload("res://Music/sfx/boss_attack_sound.mp3"),
	"attack_player": preload("res://Music/sfx/player_attack_sound.mp3"),
	"phase2_rage": preload("res://Music/sfx/phase2_rage_sound.mp3"),
	"phase2_transition": preload("res://Music/sfx/phase2_transition_sound.mp3")
}

func _ready():
	#process_mode = Node.PROCESS_MODE_ALWAYS
	streamplayer = AudioStreamPlayer.new()
	add_child(streamplayer)
	streamplayer.autoplay = false
	streamplayer.bus = "Master"
	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	sfx_player.bus = "Master"
	#streamplayer.process_mode = Node.PROCESS_MODE_ALWAYS
	#sfx_player.process_mode = Node.PROCESS_MODE_ALWAYS

func play_stream(stream: AudioStream):
	if stream != null:
		current_stream = stream
		streamplayer.stream = stream
		streamplayer.play()

func stop():
	streamplayer.stop()

func is_playing() -> bool:
	return streamplayer.playing

func play_sfx(sfx_stream: AudioStream, sfx_delay: float = 0.01, resume_delay: float = 0.01) -> void:
	if not streamplayer.playing:
		return
	var pos = streamplayer.get_playback_position()
	streamplayer.stop()
	await get_tree().create_timer(sfx_delay).timeout
	sfx_player.stream = sfx_stream
	sfx_player.play()
	await sfx_player.finished
	await get_tree().create_timer(resume_delay).timeout
	streamplayer.play()
	streamplayer.seek(pos)

func play_sfx_nopause(sfx_stream: AudioStream) -> void:
	if sfx_stream == null:
		return
	var previous_volume := sfx_player.volume_db
	sfx_player.volume_db = nopause_sfx_volume_db
	sfx_player.stream = sfx_stream
	sfx_player.play()
	await sfx_player.finished
	sfx_player.volume_db = previous_volume
