extends PlayerBaseState

func input(event: InputEvent) -> int:
	if Input.is_action_just_released('defense'):
		return State.Idle
	
	if Input.is_action_just_released('shield'):
		return State.Defense
		
	return State.Null

func physics_process(delta) -> int:
	if not player.stats.energy:
		return State.Defense
	
	return State.Null
	
func enter() -> void:
	player.activate_shield()

func exit() -> void:
	player.deactivate_shield()
