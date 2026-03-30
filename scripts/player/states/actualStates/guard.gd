extends PlayerBaseState

var vector_direction := Vector2.ZERO
const VELOCITY := 15

func _ready():
	animation = 'guard'

func input(event: InputEvent) -> int:
	if Input.is_action_just_released('guard'):
		return State.Idle
	
	if Input.is_action_just_pressed('shield') and not self.player.shield_activated and self.player.check_enough_energy(5):
		return State.Shield
		
	return State.Null

func physics_process(delta: float) -> int:
	if not self.player.hit_defense_right_direction or self.player.broke_defense:
		return State.Hit
		
	if self.player.hit_while_defense:
		self.move_and_slide(self.vector_direction) 
	
	return State.Null

func initialize_state() -> void:
	self.vector_direction = Direction.get_opposite_vector(self.player.direction) * self.VELOCITY 
	self.player.defense_pose = true

func reset_state() -> void:
	self.player.defense_regeneration()
	self.player.broke_defense = false
	self.player.defense_pose = false
	self.player.hit_while_defense = false
	self.player.hit_defense_right_direction = true
