extends Node2D
func _ready() -> void:
	hide()
	await get_tree().create_timer(60.0).timeout
	show()
