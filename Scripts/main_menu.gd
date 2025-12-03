extends Control

func _ready():
	var target_stream = AudioManager.music_list["menu"]
	if AudioManager.current_stream != target_stream:
		AudioManager.play_stream(target_stream)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/intro_lore.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")
	
func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()
