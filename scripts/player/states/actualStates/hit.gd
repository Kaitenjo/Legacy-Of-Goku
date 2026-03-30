extends PlayerBaseState

var vector_direction := Vector2.ZERO
const VELOCITY := 25

func _ready():
	self.animation = 'hit'
	
func physics_process(delta: float) -> int:
	if not self.player.stats.health:
		return State.Dead
			
	self.move_and_slide(vector_direction)
	
	if completed:
		if get_input_vector():
			return State.Run if Input.is_action_pressed('running') else State.Walk
		else:
			return State.Idle
			
	return State.Null
	
func enter() -> void:
	var hit_area := self.player.hit_area
	var player_position = self.player.position
	
	var position := hit_area.global_position
	var new_direction = Direction.get_opposite_direction(hit_area.direction)

	if abs(player_position.y - position.y) >= abs(player_position.x - position.x):
		self.player.direction = Direction.Directions.UP if player_position.y >= position.y else Direction.Directions.DOWN
	else:
		self.player.direction = Direction.Directions.LEFT if player_position.x >= position.x else Direction.Directions.RIGHT
	
	#diagonal not handled
	self.vector_direction = Direction.get_opposite_vector(self.player.direction) * self.VELOCITY
	AudioManager.play_combact_sound('Hit' + str(Utility.random_int(1, 3)))
	if await self.player.wait(0.5): return
	completed = true

func reset_state() -> void:
	self.vector_direction = Vector2.ZERO
	self.player.hit = false
	Events.emit_signal('enable_actual_entity')
