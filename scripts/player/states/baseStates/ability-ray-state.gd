extends PlayerBaseState
class_name AbilityRayState

var ability_scene: PackedScene
var ability 
var charge_time: float
	
func physics_process(delta: float) -> int:
	if self.player.hit:
		return State.Hit
		
	if self.completed:
		if self.get_input_vector():
			return State.Run if Input.is_action_pressed('shift') else State.Walk
		else:
			return State.Idle
	
	return State.Null 
	
func initialize_state() -> void:
	if not await self.player.wait(self.charge_time): return
	var ability_data := self.calculate_direction()
	
	if Input.is_action_pressed('special_attack_1'):
		ability = self.ability_scene.instantiate()
		self.play_animation(self.animation + '_2' + self.ability_data.animation)
		self.ability.position = self.player.position + self.ability.init(self.player, self.ability_data.direction, self.player.direction, self.player.LAYER, 2)
		Events.emit_signal('add_entity_attack', self.ability)
		self.player.continuous_attack_use_energy()
		self.play_sound()
		await Events.enable_player
		
	self.completed = true

func calculate_direction() -> AbilityData:
	var attack_direction: int
	var diagonal_animation := ''

	if self.player.direction8 & 1 == 0:
		attack_direction = self.player.direction
	else:
		match self.player.direction8:
			1:
				attack_direction = Direction.Directions.CN3
				diagonal_animation = '_left' if self.player.direction == Direction.Directions.DOWN else '_down'
			3:
				attack_direction = Direction.Directions.CN4
				diagonal_animation = '_right' if self.player.direction == Direction.Directions.DOWN else '_down'
			7:
				attack_direction = Direction.Directions.CN1
				diagonal_animation = '_left' if self.player.direction == Direction.Directions.UP else '_up'
			9:
				attack_direction = Direction.Directions.CN2
				diagonal_animation = '_right' if self.player.direction == Direction.Directions.UP else '_up'
	
	return AbilityData.new(attack_direction, diagonal_animation)

func play_sound() -> void:
	pass
		
func reset_state() -> void:
	if self.ability:
		self.ability.stop()
		self.ability = null

class AbilityData:
	var direction: int
	var animation: String
	
	func _init(direction: int, animation: String):
		self.direction = direction
		self.animation = animation
