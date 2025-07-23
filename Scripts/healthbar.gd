extends TextureProgressBar

@export var max_health := 100
@export var current_health := 100

func _ready():
	update_bar()

func update_health(new_health: int):
	current_health = clamp(new_health, 0, max_health)
	update_bar()

func set_max_health(new_max: int):
	max_health = new_max
	current_health = min(current_health, max_health)
	update_bar()

func update_bar():
	max_value = max_health
	value = current_health
