extends Node
var streamplayer: AudioStreamPlayer
var current_stream: AudioStream = null
var music_list = {
	"game": preload("res://music/gamemusic.mp3"),
	"menu": preload("res://music/mainmenu.mp3")
}

func _ready():
	streamplayer = AudioStreamPlayer.new()
	add_child(streamplayer)
	streamplayer.autoplay = false
	streamplayer.bus = "Master"

func play_stream(stream: AudioStream):
	if stream != null:
		current_stream = stream
		streamplayer.stream = stream
		streamplayer.play()

func stop():
	streamplayer.stop()

func is_playing() -> bool:
	return streamplayer.playing
