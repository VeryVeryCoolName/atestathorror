class_name PlayerCharacter extends CharacterBody2D
var movespeed : float = 10000.0
func _ready():
	pass
func _process(delta):
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
	direction.y = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp")
	velocity = direction * movespeed * delta
	pass
func _physics_process(delta):
	move_and_slide()
