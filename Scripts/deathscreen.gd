extends Node
func _ready():
	AudioManager.play_sfx(AudioManager.sfx_list["jingle"])
	AudioManager.stop()
	await get_tree().create_timer(2).timeout
	AudioManager.play_stream(AudioManager.music_list["menu"])
func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
