extends CharacterBody2D

var state = "idle"
var player = null
var distanceToPlayer = 1000
var moveDirection = Vector2()
var moveSpeed = 10000

func _ready():
	if is_inside_tree():
		player = get_parent().get_node("PlayerCharacter")

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
		attack()
		state = "cooldown"
	if state == "cooldown":
		moveDirection = Vector2.ZERO
		await get_tree().create_timer(0.5).timeout
		state = "idle"
	pass

func _physics_process(delta):
	velocity = moveDirection.normalized() * moveSpeed * delta
	move_and_slide()
	pass

func attack():
	print("attack")
	pass
