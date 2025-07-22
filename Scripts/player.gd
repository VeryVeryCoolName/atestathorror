class_name PlayerCharacter extends CharacterBody2D

@export var offset = 64
@export var movespeed : float = 65000.0
@export_node_path("ProgressBar") var health_bar_path
var direction: Vector2 = Vector2.ZERO
var cardinaldirection: Vector2 = Vector2.DOWN
var is_attacking: bool = false
var freeze: bool = false
var inAttack: bool = false
const MAX_HEALTH := 100
var health := MAX_HEALTH : set = set_health
@onready var attack_area = $AttackArea
@onready var animated_sprite = $AnimatedSprite2D
var health_bar: ProgressBar

func _ready():
	if health_bar_path:
		health_bar = get_node(health_bar_path)
		health_bar.max_value = MAX_HEALTH
		health_bar.value = health

func set_health(value: int):
	health = clamp(value, 0, MAX_HEALTH)
	if health_bar:
		health_bar.value = health
	if health == 0:
		freeze = true

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

# === PHYSICS ===
func _physics_process(_delta):
	if not is_attacking:
		move_and_slide()

# === ATTACK HANDLING ===
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

func _on_boss_attack_hit():
	if inAttack:
		health -= 20  

func _on_boss_attack_collide():
	inAttack = true

func _on_boss_attack_collide_exit():
	inAttack = false
