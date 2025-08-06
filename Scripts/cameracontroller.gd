extends Camera2D
@export var board_size := Vector2(1980, 1080) # nu merge bine???? nu stiu de ce
@export var transition_time := 0.3
@export var player_path: NodePath
var current_board := Vector2.ZERO
var player: PlayerCharacter
var transitioning := false

func _ready():
	AudioManager.play_stream(AudioManager.music_list["game"])
	player = get_node(player_path)
	current_board = get_board_pos(player.global_position)
	global_position = board_center(current_board)
	make_current()

func _process(_delta):
	if transitioning:
		return

	var new_board = get_board_pos(player.global_position)
	if new_board != current_board:
		start_transition(new_board)

func get_board_pos(pos: Vector2) -> Vector2:
	return Vector2(floor(pos.x / board_size.x), floor(pos.y / board_size.y))

func board_center(board: Vector2) -> Vector2:
	return board * board_size + board_size / 2

func start_transition(new_board: Vector2):
	transitioning = true
	current_board = new_board
	player.freeze = true  
	var target = board_center(new_board)
	var tween = create_tween()
	tween.tween_property(self, "global_position", target, transition_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.connect("finished", Callable(self, "_on_transition_finished"))

func _on_transition_finished():
	player.freeze = false
	transitioning = false
