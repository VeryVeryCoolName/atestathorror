extends Node2D
func _ready() -> void:
	hide()
	await get_tree().create_timer(25.0).timeout
	show()
