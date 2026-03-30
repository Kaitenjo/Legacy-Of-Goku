extends PlayerBaseState

func _ready():
	animation = 'short-teleport'
	
func physics_process(delta: float) -> int:
	if self.player.hit:
		return State.Hit
		
	if self.completed:
		if self.get_input_vector():
			return State.Run if Input.is_action_pressed('shift') else State.Walk
		else:
			return State.Idle
			
	return State.Null

func enter() -> void:
	Events.emit_signal('check_collision', self.get_direction_vector())
	var position: Vector2 = await Events.checked_collision
	
	if self.player.position != position:
		self.play_animation(self.animation)
		if await self.player.wait(0.3): return
		
		self.player.position = position
		self.play_animation(self.animation, true)
		self.player.base_use_energy(20)
		
		if await self.player.wait(0.3): return

	self.completed = true
