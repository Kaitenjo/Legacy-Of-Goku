extends PlayerBaseState
class_name ChangeMapState

var vector_direction := Vector2()
var increase := 50

func _ready():
	animation = "Walk"
	
func input(event: InputEvent) -> int:
	return State.Null

func physics_process(delta: float) -> int:
	if completed:
		return State.Idle
		
	player.move_and_collide(vector_direction * increase * delta)
	return State.Null

func setup(direction: int) -> void:
	player.direction = direction
	
func initialize_state() -> void:
	vector_direction = Direction.get_vector(player.direction)

#func completed() -> void:
	#completed = true
	#play_animation("Stand")
