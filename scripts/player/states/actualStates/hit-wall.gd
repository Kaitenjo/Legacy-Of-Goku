extends PlayerBaseState

var base_vector: Vector2
const VELOCITY := 5000

func _ready():
	self.animation = 'hit-wall'
	
func physics_process(delta):
	if self.player.hit:
		return State.Hit
	
	self.move_and_slide(self.base_vector * delta)
	
	if self.completed:
		return State.Idle

	return State.Null
	
func initialize_state():
	self.base_vector = Direction.get_opposite_vector(self.player.direction).normalized() * self.VELOCITY

	self.player.start_shake()
	AudioManager.play_combact_sound('RunIntoWall')
	
	if await self.player.wait(0.5): return
	
	self.completed = true

func reset_state():
	self.player.stop_shake()
