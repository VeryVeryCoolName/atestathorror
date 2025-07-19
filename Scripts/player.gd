class_name PlayerCharacter extends CharacterBody2D

@export var movespeed : float = 65000.0
var cardinaldirection : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO 
var is_attacking: bool = false

@onready var attack_area = $AttackArea

func _process(delta):
	
	if not is_attacking:
		direction.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
		direction.y = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp")
		
		if direction != Vector2.ZERO:
			cardinaldirection = direction.normalized().round()
		
		velocity = direction.normalized() * movespeed * delta

	if Input.is_action_just_pressed("Attack") and not is_attacking:
		attack()

func _physics_process(delta):
	if not is_attacking:
		move_and_slide()

func attack():
	is_attacking = true
	velocity = Vector2.ZERO  
	$AttackArea.monitoring = true
	$AttackArea.position = cardinaldirection * 16  
	await get_tree().create_timer(0.2).timeout  
	$AttackArea.monitoring = false
	is_attacking = false
