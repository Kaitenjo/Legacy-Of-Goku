extends PlayerBaseState

var diagonal_directions = {
	1: Direction.Directions.CN3,
	3: Direction.Directions.CN4,
	7: Direction.Directions.CN1,
	9: Direction.Directions.CN2
}

var ki_blast_scene := load(Paths.KI_BLAST)
var can_concatenate := false

func _ready():
	animation = "Ki Blast"
	
func input(event: InputEvent) -> int:
	if can_concatenate:
		if event.is_action_pressed("ki_blast") and not event.is_echo() and player.check_enough_energy(2):
			return State.KiBlast
	
	return State.Null 
	
func physics_process(delta: float) -> int:
	if player.hit:
		return State.Hit
		
	if completed:
		if get_input_vector():
			return State.Run if Input.is_action_pressed("running") else State.Walk
		else:
			return State.Idle
	
	return State.Null
	
func enter():
	player.base_use_energy(2)
	var direction := Direction.Directions.NONE
	
	direction = set_ki_blast_direction(direction)
	play_ki_blast_animation()
	new_ki_blast(direction)
	
	AudioManager.play_combact_sound("KiBlast" + str(Utility.random_int(1, 2)))
	
	if not await player.wait(0.3): return
	can_concatenate = true
	
	if not await player.wait(0.3): return
	can_concatenate = false
	completed = true
	direction = Direction.Directions.NONE

func set_ki_blast_direction(direction: int) -> int:
	return player.direction if not player.direction8 & 1 else diagonal_directions[player.direction8]

func play_ki_blast_animation() -> void:
	play_animation(animation + (" 1" if not "Ki Blast" in player.sprite.animation else (" 3" if "2" in player.sprite.animation else " 2")))
	
func new_ki_blast(direction: int) -> void:
	var ki_blast: KiBlast = ki_blast_scene.instance()
	ki_blast.position = player.position + ki_blast.init(player, direction, player.direction, player.LAYER, 2)
#	statistics.usage_update_energy(2)
	Events.emit_signal("add_entity_attack", ki_blast)
	
func reset_state():
	can_concatenate = false
