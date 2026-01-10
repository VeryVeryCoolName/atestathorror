extends Control
func _ready() -> void:
	var db := AudioServer.get_bus_volume_db(0)
	$Volume.value = db_to_linear(db)

func _on_main_menu_pressed() -> void:
	# await AudioManager.play_sfx(AudioManager.sfx_list["howl"])
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_volume_value_changed(value: float) -> void:
	value = clamp(value, 0.0, 1.0)
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
