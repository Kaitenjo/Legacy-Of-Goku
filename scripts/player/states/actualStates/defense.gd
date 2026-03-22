extends PlayerBaseState

var vector_direction: Vector2 = Vector2.ZERO
var INCREASE: int = 15

func _ready():
	animation = 'Defense'

func input(event: InputEvent) -> int:
	if Input.is_action_just_released("defense"):
		return State.Idle
	
	if Input.is_action_just_pressed("shield") and not player.shield_activated and player.check_enough_energy(5):
		return State.Shield
		
	return State.Null

func physics_process(delta: float) -> int:
	if not player.hit_defense_right_direction or player.broke_defense:
		return State.Hit
		
	if player.hit_while_defense:
		player.move_and_slide(vector_direction * INCREASE) 
	
	return State.Null

func initialize_state() -> void:
	vector_direction = Direction.get_opposite_vector(player.direction) 
	player.defense_pose = true

func reset_state() -> void:
	player.defense_regeneration()
	player.broke_defense = false
	player.defense_pose = false
	player.hit_while_defense = false
	player.hit_defense_right_direction = true
