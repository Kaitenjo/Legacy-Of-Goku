extends PlayerBaseState

var diagonal_directions := {
	1: Direction.Directions.CN3,
	3: Direction.Directions.CN4,
	7: Direction.Directions.CN1,
	9: Direction.Directions.CN2
}

var ki_blast_scene = preload(Paths.KI_BLAST)
var can_concatenate := false

func _ready():
	self.animation = 'ki-blast'
	
func input(event: InputEvent) -> int:
	if self.can_concatenate and event.is_action_pressed('ki_blast') and not event.is_echo() and self.player.check_enough_energy(2):
		return State.KiBlast
	
	return State.Null 
	
func physics_process(delta: float) -> int:
	if self.player.hit:
		return State.Hit
		
	if self.completed:
		if self.get_input_vector():
			return State.Run if Input.is_action_pressed('running') else State.Walk
		else:
			return State.Idle
	
	return State.Null
	
func enter():
	self.player.base_use_energy(2)
	var direction := Direction.Directions.NONE
	
	self.direction = set_direction(direction)
	var number = '_1' if not 'Ki Blast' in self.sprite.animation else ('_3' if '2' in self.sprite.animation else '_2')
	self.play_animation(animation + number)
	self.new_ki_blast(direction)
	
	AudioManager.play_combact_sound('KiBlast' + str(Utility.random_int(1, 2)))
	
	if not await self.player.wait(0.3): return
	self.can_concatenate = true
	
	if not await self.player.wait(0.3): return
	self.can_concatenate = false
	self.completed = true
	self.direction = Direction.Directions.NONE

func set_direction(direction: int) -> int:
	return self.player.direction if not self.player.direction8 & 1 else diagonal_directions[self.player.direction8]
	
func new_ki_blast(direction: int) -> void:
	var ki_blast: KiBlast = ki_blast_scene.instantiate()
	ki_blast.position = self.player.position + ki_blast.init(player, direction, self.player.direction, self.player.LAYER, 2)
	self.statistics.usage_update_energy(2)
	Events.emit_signal('add_entity_attack', ki_blast)
	
func reset_state():
	self.can_concatenate = false
