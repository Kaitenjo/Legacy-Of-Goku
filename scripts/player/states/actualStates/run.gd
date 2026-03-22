extends MoveState

var hit_wall: bool = false

func _ready():
	animation = "Run"
	
func input(_event: InputEvent) -> int:
	if Input.is_action_just_released("running"):
		return State.Walk
	
	return check_player_input()

func specific_process() -> int:
	if hit_wall:
		return State.HitWall
	
	return State.Null
	
func initialize_state():
	hit_wall = false # To prevent a bug that happens when you are changing map. Even if you call disable_hit_wall in the specific exit, the signal below is called (fucked up timing i guess)
	player.enable_hit_wall()
	vector_increase = 12000

func reset_state():
	hit_wall = false
	player.disable_hit_wall()
	
func _on_HitWall_body_entered(_body):
	hit_wall = true
