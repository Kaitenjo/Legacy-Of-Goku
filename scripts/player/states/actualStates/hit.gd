extends PlayerBaseState

const INCREASE: int = 25
var vector_direction: Vector2 = Vector2.ZERO

func _ready():
	animation = "Hit"
	
func physics_process(delta: float) -> int:
	if not player.stats.health:
		return State.Dead
			
	player.move_and_slide(vector_direction * INCREASE)
	
	if completed:
		if get_input_vector():
			return State.Run if Input.is_action_pressed("running") else State.Walk
		else:
			return State.Idle
			
	return State.Null
	
func enter() -> void:
	var position: Vector2 = player.hit_area.global_position
	
	var new_direction = Direction.get_opposite_direction(player.hit_area.direction)

	if abs(player.position.y - position.y) >= abs(player.position.x - position.x):
		player.direction = Direction.Directions.UP if player.position.y >= position.y else Direction.Directions.DOWN
	else:
		player.direction = Direction.Directions.LEFT if player.position.x >= position.x else Direction.Directions.RIGHT
	
	#diagonal not handled
	vector_direction = Direction.get_opposite_vector(player.direction)
	AudioManager.play_combact_sound("Hit" + str(Utility.random_int(1, 3)))
	if await player.wait(0.5): return
	completed = true

func reset_state() -> void:
	vector_direction = Vector2.ZERO
	player.hit = false
	Events.emit_signal("enable_actual_entity")
