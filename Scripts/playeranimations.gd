extends AnimatedSprite2D

func _process(_delta):
	if Input.is_action_pressed("MoveUp"):
		play("moving_up")
	elif Input.is_action_pressed("MoveDown"):
		play("moving_down")
	elif Input.is_action_pressed("MoveRight"):
		play("moving_right")
	elif Input.is_action_pressed("MoveLeft"):
		play("moving_left")
	else:
		play("idle")
