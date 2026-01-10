extends Node

@export var introtimer = 18 
@export var animationPlayer1 : AnimationPlayer
@export var animationPlayer2 : AnimationPlayer
@export var animationPlayer3 : AnimationPlayer
@export var animationPlayer4 : AnimationPlayer
@export var animationPlayer5 : AnimationPlayer

func _ready():
	if animationPlayer1:
		animationPlayer1.play("fade_in1")
	if animationPlayer2:
		animationPlayer2.play("fade_in2")
	if animationPlayer3:
		animationPlayer3.play("fade_in3")
	if animationPlayer4:
		animationPlayer4.play("fade_in4")
	if animationPlayer5:
		animationPlayer5.play("fade_in5")
	await get_tree().create_timer(introtimer).timeout
	AudioManager.stop()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
