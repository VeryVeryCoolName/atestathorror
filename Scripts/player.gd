class_name PlayerCharacter extends CharacterBody2D
@export var offset := 86
@export var movespeed : float = 40000.0
@export_node_path("TextureProgressBar") var health_bar_path
var direction: Vector2 = Vector2.ZERO
var cardinaldirection: Vector2 = Vector2.DOWN
var is_attacking: bool = false
var freeze: bool = false
var inAttack: bool = false
const MAX_HEALTH := 100
var health := MAX_HEALTH : set = set_health
@onready var attack_area = $AttackArea
@onready var animated_sprite = $AnimatedSprite2D
@onready var weapon_sprite = get_node("AttackArea/AnimatedSprite2D")
var health_bar: TextureProgressBar

var phase2Boss

func _ready():
	if health_bar_path:
		health_bar = get_node(health_bar_path)
		health_bar.max_value = MAX_HEALTH
		health_bar.value = health
	phase2Boss = get_tree().get_nodes_in_group("phase2boss")
	phase2Boss[0].attackHit.connect(_on_boss_attack_hit)
	phase2Boss[0].attackCollide.connect(_on_boss_attack_collide)
	phase2Boss[0].attackCollideExit.connect(_on_boss_attack_collide_exit)
	$AttackArea.body_entered.connect(_on_attack_area_body_entered)
	$AttackArea.body_entered.connect(func(body):
		print("BODY ENTERED: ", body.name))
	$AttackArea.body_exited.connect(func(body):
		print("BODY EXITED: ", body.name))

func set_health(value: int):
	health = clamp(value, 0, MAX_HEALTH)
	if health_bar:
		health_bar.value = health
	if health == 0:
		freeze = true
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

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
	
	weapon_sprite.show()
	match cardinaldirection:
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

func _on_attack_area_body_entered(body):
	#if body.is_in_group("phase2boss"):
	if body.has_method("take_damage"):
		body.take_damage(9)
	if not is_attacking:
		return  # as zice return 0 dar nu stiu daca e rau
	

func _on_boss_attack_hit():
	if inAttack:
		health -= 10  

func _on_boss_attack_collide():
	inAttack = true

func _on_boss_attack_collide_exit():
	inAttack = false

#func _on_boss_kill():
#	phase2Boss = get_tree().get_nodes_in_group("Phase2Character")
#	
#
