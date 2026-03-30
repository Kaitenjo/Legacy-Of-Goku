extends PlayerBaseState

func _ready():
	self.animation = 'attack'
	
func physics_process(delta: float) -> int:
	if self.player.hit:
		return State.Hit
		
	if self.completed:
		if self.get_input_vector():
			return State.Run if Input.is_action_pressed('running') else State.Walk
		else:
			return State.Idle
	
	return State.Null 

func enter():
	self.player.play_attack_animation(animation, false)
	self.player.enable_base_attack()
	AudioManager.play_combact_sound('Punch' + str(Utility.random_int(1, 2)))
	
	if not await self.player.wait(0.1): return
	self.player.disable_base_attack()
	if not await self.player.wait(0.16): return
	self.play_animation('Stand')
	self.completed = true
	
func reset_state():
	self.player.disable_base_attack()
