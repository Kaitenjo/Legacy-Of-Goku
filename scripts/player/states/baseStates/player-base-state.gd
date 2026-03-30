extends BaseState
class_name PlayerBaseState

const inputs: Array[String] = [
	'ui_left', 
	'ui_right', 
	'ui_up', 
	'ui_down'
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

var player: Player

var sprite: AnimatedSprite2D:
	get(): return self.player.sprite
	
func input(event: InputEvent) -> int:
	return State.Null

func get_input_vector() -> Vector2:
	return Input.callv('get_vector', self.inputs)

func check_player_input() -> int:
	for action in self.player.actions:
		if Input.is_action_just_pressed(action.action_name) and self.player.check_enough_energy(action.energy_used):
			return action.state
			
	return State.Null
	
func get_direction_vector(d: int = player.direction8) -> Vector2:
	var dx = (d - 5) % 3 * (1 - ((d & 3) / 3) * 2)
	var dy = (5 - d) / 2
	return Vector2(sign(dx), sign(dy)).normalized()
	
#PLAYER SHORTCUTS
func play_animation(animation: String, backward := false) -> void:
	self.player.play_animation(animation, backward)

func move_and_slide(velocity: Vector2) -> void:
	self.player.velocity = velocity
	self.player.move_and_slide()
