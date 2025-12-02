extends Node

@export var animationPlayer1 : AnimationPlayer
@export var animationPlayer2 : AnimationPlayer
@export var animationPlayer3 : AnimationPlayer
@export var animationPlayer4 : AnimationPlayer
@export var animationPlayer5 : AnimationPlayer

func _ready():
	animationPlayer1.play("fade_in1")
	animationPlayer2.play("fade_in2")
	animationPlayer3.play("fade_in3")
	animationPlayer4.play("fade_in4")
	animationPlayer5.play("fade_in5")
