extends PlayerBaseState
class_name ChangeMapState

var vector_direction := Vector2()
var increase := 50

func _ready():
	self.animation = 'walk'
	
func input(event: InputEvent) -> int:
	return State.Null

func physics_process(delta: float) -> int:
	if self.completed:
		return State.Idle
		
	self.player.move_and_collide(self.vector_direction * self.increase * delta)
	return State.Null

func setup(direction: int) -> void:
	self.player.direction = direction
	
func initialize_state() -> void:
	self.vector_direction = Direction.get_vector(self.player.direction)

func complete() -> void:
	self.completed = true
	self.play_animation('idle')
