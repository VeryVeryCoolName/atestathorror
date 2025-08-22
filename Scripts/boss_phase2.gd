extends CharacterBody2D

@onready var player = get_parent().get_node("PlayerCharacter")
var state = "idle"
var distanceToPlayer = 1000
var moveDirection = Vector2.ZERO
var attackDirection = Vector2.ZERO
var moveSpeed = 10000
@onready var animatedsprite = $AnimatedSprite2D
@onready var motionlesssprite = $Sprite2D

var bossHealth = 100. #sa nu modifici numele la variabila asta daca faci boss hp

var attackScene = load("res://Prefabs/wolf_claw_attack.tscn")
var attack_animatedsprite : AnimatedSprite2D
var attack
var attackChoice : float
var isCooldownFinished = true
var attackFrameCounter = 0
signal attackHit
signal attackCollide
signal attackCollideExit

var isRaging = false
@onready var rageCollision = $RageCollision

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
		if moveDirection.length() < 225:
			state = "attack"
	if state == "attack":
		attackChoice = randfn(0.0, 1.0)
		if attackChoice < 0.2:
			rage()
		else: startAttack()
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

func rage():
	animatedsprite.play("rage")
	isCooldownFinished = false
	isRaging = true
	rageCollision.disabled = false
	rageCollision.body_entered.connect(_onRageCollision)
	rageCollision.body_exited.connect(_onRageCollisionExit)
	pass
	
func heal(healAmount: float):
	if bossHealth + healAmount > 100:
		bossHealth = 100
	else: bossHealth += healAmount
	pass

func startAttack():
	isCooldownFinished = false
	attackDirection = moveDirection.normalized().round()
	attack = attackScene.instantiate()
	add_child(attack)
	attack.body_entered.connect(_onAttackCollision)
	attack.body_exited.connect(_onAttackCollisionExit)
	attack_animatedsprite = attack.get_node("AnimatedSprite2D")
	attack.global_position = position + attackDirection * 175
	attack.scale = Vector2(6, 6)
	attack_animatedsprite.play("default")
	attack_animatedsprite.animation_finished.connect(_finishAttack)
	attack_animatedsprite.frame_changed.connect(_onAttackFrameChange)
	pass
	
func _finishAttack():
	if is_instance_valid(attack):
		attack.queue_free()
	attackFrameCounter = 0
	isCooldownFinished = true
	pass

# La ultimele astea 3 o sa dau mald cand facem phase 2
# (ca o sa aiba mai multe tipuri de atac)
	
func _onAttackFrameChange():
	attackFrameCounter += 1
	
func _onAttackCollision(_body: Node2D):
	attackCollide.emit()
	
func _onAttackCollisionExit(_body: Node2D):
	attackCollideExit.emit()
	
func _onRageCollision():
	attackCollide.emit()

func _onRageCollisionExit():
	attackCollideExit.emit()

func _on_animation_finished():
	if isRaging:
		rageCollision.disabled = true
		heal(10)
		isCooldownFinished = true
