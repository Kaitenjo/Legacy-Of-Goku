extends BaseState
class_name PlayerBaseState

const inputs: Array = [
	[
		"left_stick_left", 
		"left_stick_right", 
		"left_stick_up", 
		"left_stick_down"
	], 
	[
		"move_left", 
		"move_right", 
		"move_up", 
		"move_down"
	]
]
	
enum State {
	Null,
	Idle,
	Walk,
	ChangeMap,
	FlyChangeMap,
	Run,
	BaseAttack,
	Defense,
	Shield,
	FastAttack,
	KiBlast,
	Teleport,
	Hit,
	HitWall,
	Dead,
	Kamehameha,
	SpecialBeamCannon,
	FinalFlash
}

var player

func input(event: InputEvent) -> int:
	return State.Null

func get_input_vector() -> Vector2:
	var vector: Vector2
	
	for args in inputs:
		vector = Input.callv("get_vector", args)
		if vector != Vector2.ZERO: 
			break
		
	return vector

func check_player_input() -> int:
	for action in player.actions:
		if Input.is_action_just_pressed(action.action_name) and player.check_enough_energy(action.energy_used):
			return action.state
			
	return State.Null
	
func get_direction_vector(d: int = player.direction8) -> Vector2:
	var dx = (d - 5) % 3 * (1 - ((d & 3) / 3) * 2)
	var dy = (5 - d) / 2
	return Vector2(sign(dx), sign(dy)).normalized()
	
#PLAYER SHORTCUTS
func play_animation(animation: String, backward: bool = false) -> void:
	player.play_animation(animation, backward)
