extends PlayerBaseState

func _ready():
	animation = "Stand"
	
func input(event: InputEvent) -> int:
	return check_player_input()

func physics_process(delta: float) -> int:
	if player.hit:
		return State.Hit
		
	if get_input_vector():
		return State.Run if Input.is_action_pressed("running") else State.Walk 
	return State.Null

func initialize_state():
	player.direction8 = [4, 6, 8, 2][player.direction]
	if not await player.wait(9): return
	player.sprite.flip_h = false
	player.sprite.play("Afk", false)
	if not await player.wait(0.5): return
	player.sprite.play("Afk 2", false)
