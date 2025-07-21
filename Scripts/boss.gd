extends CharacterBody2D

var state = "idle"
var player = null
var moveDirection = Vector2()
var moveSpeed = 10000

func _process(_delta):
	if !player && is_inside_tree():
		player = get_parent().get_node("PlayerCharacter")
	if state == "idle" and player:
		state = "move"
	if state == "move":
		#if distanceToPlayer() < 50:
			#state = "attack"
		var playerPosition = player.position
		moveDirection.x = playerPosition.x - position.x
		moveDirection.y = playerPosition.y - position.y
		print(moveDirection.x)
		print(moveDirection.y)
	if state == "cooldown":
		state = "idle"
	pass

func _physics_process(delta):
	velocity = moveDirection.normalized() * moveSpeed * delta
	move_and_slide()
	pass

func distanceToPlayer():
	pass
