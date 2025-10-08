extends CanvasLayer

var pausesfx = AudioManager.sfx_list["pause"]
var unpausesfx = AudioManager.sfx_list["unpause"]

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$MenuRoot.hide() 

func pause():
	$MenuRoot.show()
	get_tree().paused = true

func resume():
	get_tree().paused = false
	$MenuRoot.hide()

func escapekey():
	if Input.is_action_just_pressed("Pause"):
		if get_tree().paused:
			resume()
			await get_tree().create_timer(0.1).timeout
			AudioManager.play_sfx(unpausesfx)
		else:
			AudioManager.play_sfx(pausesfx)
			pause()

func _process(_delta):
	escapekey()

func _on_resume_pressed():
	resume()
	await get_tree().create_timer(0.1).timeout
	AudioManager.play_sfx(unpausesfx)

func _on_quit_pressed():
	get_tree().quit()
