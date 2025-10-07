extends Node
var streamplayer: AudioStreamPlayer
var sfx_player: AudioStreamPlayer
var current_stream: AudioStream = null
var music_list = {
	"game": preload("res://music/gamemusic.mp3"),
	"menu": preload("res://music/mainmenu.mp3")
}
var sfx_list = {
	"howl": preload("res://music/sfx/temp.mp3"), 
	"pause": preload("res://music/sfx/pause.wav"),
	"unpause": preload("res://music/sfx/unpause.wav")
}

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	streamplayer = AudioStreamPlayer.new()
	add_child(streamplayer)
	streamplayer.autoplay = false
	streamplayer.bus = "Master"
	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	sfx_player.bus = "Master"
	streamplayer.process_mode = Node.PROCESS_MODE_ALWAYS
	sfx_player.process_mode = Node.PROCESS_MODE_ALWAYS

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
