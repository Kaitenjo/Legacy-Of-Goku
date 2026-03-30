extends MoveState

func _ready():
	self.animation = 'walk'
	
func input(_event: InputEvent) -> int:
	if Input.is_action_pressed('shift'):
		return State.Run
		
	return self.check_player_input()

func initialize_state():
	self.velocity = 5000
