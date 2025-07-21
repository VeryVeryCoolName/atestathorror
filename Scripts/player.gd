class_name PlayerCharacter extends CharacterBody2D

@export var offset = 64
@export var movespeed : float = 65000.0
var cardinaldirection : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO 
var is_attacking: bool = false
@onready var attack_area = $AttackArea
@onready var animated_sprite = $AnimatedSprite2D
var freeze : = false

func _process(delta):
	if freeze:
		velocity = Vector2.ZERO
		return
	if not is_attacking:
		direction.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
		direction.y = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp")
		
		if direction != Vector2.ZERO:
			cardinaldirection = direction.normalized().round()
		
		velocity = direction.normalized() * movespeed * delta

	if Input.is_action_just_pressed("Attack") and not is_attacking:
		attack()

func _physics_process(_delta):
	if not is_attacking:
		move_and_slide()

func attack():
	is_attacking = true
	velocity = Vector2.ZERO
	var original_position = attack_area.position  
	match cardinaldirection:
		Vector2.UP:
			animated_sprite.play("attack_up")
			attack_area.position = Vector2(0, -offset)
		Vector2.DOWN:
			animated_sprite.play("attack_down")
			attack_area.position = Vector2(0, offset)
		Vector2.LEFT:
			animated_sprite.play("attack_left")
			attack_area.position = Vector2(-offset, 0)
		Vector2.RIGHT:
			animated_sprite.play("attack_right")
			attack_area.position = Vector2(offset, 0)

	attack_area.monitoring = true

	await get_tree().create_timer(0.2).timeout

	attack_area.monitoring = false
	attack_area.position = original_position
	is_attacking = false
