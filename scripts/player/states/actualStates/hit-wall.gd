extends PlayerBaseState

var base_vector: Vector2
const increase: int = 5000

func _ready():
	animation = "Hit Wall"
	
func physics_process(delta):
	if player.hit:
		return State.Hit
		
	player.move_and_slide(base_vector.normalized() * increase * delta)
	
	if completed:
		return State.Idle

	return State.Null
	
func initialize_state():
	base_vector = Direction.get_opposite_vector(player.direction)

	player.start_shake()
	AudioManager.play_combact_sound("RunIntoWall")
	
	if await player.wait(0.5): return
	
	completed = true

func reset_state():
	player.stop_shake()
