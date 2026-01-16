class_name PlayerCharacter
extends CharacterBody2D
@export var offset := 86
@export var move_speed := 425.0
@export var attack_cooldown := 0.35
@export_node_path("TextureProgressBar") var health_bar_path
const MAX_HEALTH := 100
var attack_cooldown_timer := 0.0
var health := MAX_HEALTH : set = set_health
var freeze := false
var is_attacking := false
var in_attack := false
var cardinal_direction := Vector2.DOWN
@onready var attack_area: Area2D = $AttackArea
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon_sprite: AnimatedSprite2D = $AttackArea/AnimatedSprite2D

var health_bar: TextureProgressBar
var phase2_boss

func _ready() -> void:
	if health_bar_path:
		health_bar = get_node(health_bar_path)
		health_bar.max_value = MAX_HEALTH
		health_bar.value = health

	phase2_boss = get_tree().get_nodes_in_group("phase2boss")
	if phase2_boss.size() > 0:
		phase2_boss[0].attackHit.connect(_on_boss_attack_hit)
		phase2_boss[0].attackCollide.connect(_on_boss_attack_collide)
		phase2_boss[0].attackCollideExit.connect(_on_boss_attack_collide_exit)

	attack_area.body_entered.connect(_on_attack_area_body_entered)
	attack_area.monitoring = false
	weapon_sprite.hide()

func _physics_process(_delta: float) -> void:
	if freeze:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	if not is_attacking:
		_handle_movement()
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _process(delta: float) -> void:
	if attack_cooldown_timer > 0.0:
		attack_cooldown_timer -= delta

	if Input.is_action_just_pressed("Attack") \
	and not is_attacking \
	and not freeze \
	and attack_cooldown_timer <= 0.0:
		attack()

func _handle_movement() -> void:
	var input_vector := Vector2(
		Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft"),
		Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp")
	)

	if input_vector != Vector2.ZERO:
		cardinal_direction = input_vector.normalized().round()
		velocity = input_vector.normalized() * move_speed
	else:
		velocity = Vector2.ZERO

func attack() -> void:
	is_attacking = true
	attack_cooldown_timer = attack_cooldown
	velocity = Vector2.ZERO

	var original_position := attack_area.position
	weapon_sprite.show()

	match cardinal_direction:
		Vector2.UP:
			weapon_sprite.play("attacking_up")
			attack_area.position = Vector2(0, -offset)
		Vector2.DOWN:
			weapon_sprite.play("attacking_down")
			attack_area.position = Vector2(0, offset)
		Vector2.LEFT:
			weapon_sprite.play("attacking_left")
			attack_area.position = Vector2(-offset, 0)
		Vector2.RIGHT:
			weapon_sprite.play("attacking_right")
			attack_area.position = Vector2(offset, 0)

	attack_area.monitoring = true

	await get_tree().create_timer(0.2).timeout

	weapon_sprite.hide()
	attack_area.monitoring = false
	attack_area.position = original_position
	is_attacking = false

func set_health(value: int) -> void:
	health = clamp(value, 0, MAX_HEALTH)
	if health_bar:
		health_bar.value = health

	if health <= 0:
		freeze = true
		get_tree().change_scene_to_file("res://Scenes/death.tscn")

func _on_attack_area_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(7)

func _on_boss_attack_hit() -> void:
	if in_attack:
		health -= 14

func _on_boss_attack_collide() -> void:
	in_attack = true

func _on_boss_attack_collide_exit() -> void:
	in_attack = false
