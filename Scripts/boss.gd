extends CharacterBody2D

@onready var player = get_parent().get_node("PlayerCharacter")
var state = "idle"
var distanceToPlayer = 1000
var moveDirection = Vector2.ZERO
var attackDirection = Vector2.ZERO
var moveSpeed = 10000

var attackScene = load("res://Prefabs/wolf_claw_attack.tscn")
var attack_animatedsprite : AnimatedSprite2D
var attack
var isCooldownFinished = true
var attackFrameCounter = 0
signal attackHit
signal attackCollide
signal attackCollideExit

func _process(_delta):
	if state == "idle" and player:
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
