extends PlayerBaseState

func _ready():
	animation = 'Short Teleport'
	
func physics_process(delta: float) -> int:
	if player.hit:
		return State.Hit
		
	if completed:
		if get_input_vector():
			return State.Run if Input.is_action_pressed('running') else State.Walk
		else:
			return State.Idle
			
	return State.Null

func enter() -> void:
	Events.emit_signal('check_collision', get_direction_vector())
	var position: Vector2 = await Events.checked_collision
	
	if player.position != position:
		play_animation(animation)
		if await player.wait(0.3): return
		
		player.position = position
		play_animation(animation, true)
		player.base_use_energy(20)
		
		if await player.wait(0.3): return

	completed = true
