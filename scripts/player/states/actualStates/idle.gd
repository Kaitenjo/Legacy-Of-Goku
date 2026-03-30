extends PlayerBaseState

func _ready():
	self.animation = 'idle'
	
func input(event: InputEvent) -> int:
	return self.check_player_input()

func physics_process(delta: float) -> int:
	if self.player.hit:
		return State.Hit
		
	if self.get_input_vector():
		return State.Run if Input.is_action_pressed('shift') else State.Walk
		
	return State.Null

func initialize_state():
	self.player.direction8 = [4, 6, 8, 2][self.player.direction]
	if not await self.player.wait(9): return
	self.sprite.flip_h = false
	self.sprite.play('afk', false)
	if not await self.player.wait(0.5): return
	self.sprite.play('afk_2', false)
