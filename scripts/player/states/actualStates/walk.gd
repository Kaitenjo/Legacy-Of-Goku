extends MoveState

func _ready():
	animation = 'Walk'
	
func input(_event: InputEvent) -> int:
	if Input.is_action_pressed('running'):
		return State.Run
		
	return check_player_input()

func initialize_state():
	vector_increase = 5000
