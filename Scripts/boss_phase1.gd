extends CharacterBody2D

@onready var player = get_parent().get_node("PlayerCharacter")
var state = "idle"
var distanceToPlayer = 1000
var moveDirection = Vector2.ZERO
var attackDirection = Vector2.ZERO
var moveSpeed = 10000
const maxHealth = 100
var health = 100
@export_node_path("TextureProgressBar") var healthBarPath
var healthBar : TextureProgressBar

@onready var animatedsprite = $AnimatedSprite2D
@onready var motionlesssprite = $Sprite2D

var attackScene = preload("res://Prefabs/wolf_claw_attack.tscn")
var attack_animatedsprite : AnimatedSprite2D
var attack
var isCooldownFinished = true
var attackFrameCounter = 0
signal attackHit
signal attackCollide
signal attackCollideExit

signal death

@onready var bossPhase2 = get_parent().get_node("Phase2Character")

func _ready():
	set_process(false)
	set_physics_process(false)
	hide()
	await get_tree().create_timer(60.0).timeout
	show()
	set_process(true)
	set_physics_process(true)
	AudioManager.play_stream(AudioManager.music_list["phase1"])
	if healthBarPath:
		healthBar = get_node(healthBarPath)
		healthBar.get_parent().show()
		healthBar.max_value = maxHealth
		healthBar.value = health

func _process(_delta):
	if state == "idle":
		animatedsprite.play("default")
		animatedsprite.hide()
		motionlesssprite.show()
		if player:
			state = "move"
	if state == "move":
		var playerPosition = player.position
		moveDirection.x = playerPosition.x - position.x
		moveDirection.y = playerPosition.y - position.y
		if moveDirection.length() < 200:
			state = "attack"
	if state == "attack":
		startAttack()
		state = "cooldown"
	if state == "cooldown":
		moveDirection = Vector2.ZERO
		if isCooldownFinished:
			state = "idle"
	if attackFrameCounter == 3:
		attackHit.emit()
		attackFrameCounter = 0
	if velocity.x + velocity.y != 0:
		animatedsprite.show()
		motionlesssprite.hide()
	else:
		animatedsprite.hide()
		motionlesssprite.show()
	if velocity.y < 0 and abs(velocity.x) < 150:
		animatedsprite.play("walking_up")
	elif velocity.y > 0 and abs(velocity.x) < 150:
		animatedsprite.play("walking_down")
	elif velocity.x > 0:
		animatedsprite.play("walking_right")
	elif velocity.x < 0:
		animatedsprite.play("walking_left")
	pass

func _physics_process(delta):
	velocity = moveDirection.normalized() * moveSpeed * delta
	move_and_slide()
	pass

func startAttack():
	isCooldownFinished = false
	attackDirection = moveDirection.normalized().round()
	attack = attackScene.instantiate()
	add_child(attack)
	attack.body_entered.connect(_onCollision)
	attack.body_exited.connect(_onCollisionExit)
	attack_animatedsprite = attack.get_node("AnimatedSprite2D")
	attack.global_position = position + attackDirection * 125
	attack.scale = Vector2(6, 6)
	attack_animatedsprite.play("default")
	attack_animatedsprite.animation_finished.connect(_finishAttack)
	attack_animatedsprite.frame_changed.connect(_onAttackFrameChange)
	
func _finishAttack():
	if is_instance_valid(attack):
		attack.queue_free()
	attackFrameCounter = 0
	isCooldownFinished = true

# La ultimele astea 3 o sa dau mald cand facem phase 2
# (ca o sa aiba mai multe tipuri de atac)
	
func _onAttackFrameChange():
	attackFrameCounter += 1
	
func _onCollision(_body: Node2D):
	attackCollide.emit()
	
func _onCollisionExit(_body: Node2D):
	attackCollideExit.emit()
	
func take_damage(amount: int):
	health -= amount
	if healthBar:
		healthBar.value = health
	print("Ai dat ", amount, " damage. HP ramas: ", health)
	if health <= 0:
		die()

func die():
	print("Boss defeated!")
	if healthBar:
		healthBar.get_parent().hide()
	# asta e fara pauza AudioManager.play_sfx_nopause(AudioManager.sfx_list["howl"])
	AudioManager.play_sfx(AudioManager.sfx_list["howl"])
	death.emit()
	AudioManager.play_stream(AudioManager.music_list["phase2"])
	bossPhase2.global_position = position
	queue_free()
