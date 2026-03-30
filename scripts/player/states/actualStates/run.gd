extends MoveState

var hit_wall := false

func _ready():
	self.animation = 'run'
	
func input(_event: InputEvent) -> int:
	if Input.is_action_just_released('shift'):
		return State.Walk
	
	return self.check_player_input()

func specific_process() -> int:
	if self.hit_wall:
		return State.HitWall
	
	return State.Null
	
func initialize_state():
	self.hit_wall = false # To prevent a bug that happens when you are changing map. Even if you call disable_hit_wall in the specific exit, the signal below is called (fucked up timing i guess)
	self.player.enable_hit_wall()
	self.velocity = 12000

func reset_state():
	self.hit_wall = false
	self.player.disable_hit_wall()
	
func _on_HitWall_body_entered(_body):
	self.hit_wall = true
