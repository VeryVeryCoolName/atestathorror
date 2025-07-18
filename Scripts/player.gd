class_name PlayerCharacter extends CharacterBody2D

var movespeed : float = 65000.0
var cardinaldirection : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO 

func _ready():
	pass
func _process(delta):
	direction.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
	direction.y = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp")
	velocity = direction.normalized() * movespeed * delta
	pass
func _physics_process(delta):
	move_and_slide()
	pass
