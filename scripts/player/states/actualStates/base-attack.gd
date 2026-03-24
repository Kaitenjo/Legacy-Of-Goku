extends PlayerBaseState

func _ready():
	animation = 'Attack'
	
func physics_process(delta: float) -> int:
	if player.hit:
		return State.Hit
		
	if completed:
		if get_input_vector():
			return State.Run if Input.is_action_pressed('running') else State.Walk
		else:
			return State.Idle
	
	return State.Null 

func enter():
	player.play_attack_animation(animation, false)
	player.enable_base_attack()
	AudioManager.play_combact_sound('Punch' + str(Utility.random_int(1, 2)))
	
	if not await player.wait(0.1): return
	player.disable_base_attack()
	if not await player.wait(0.16): return
	play_animation('Stand')
	completed = true
	
func reset_state():
	player.disable_base_attack()
