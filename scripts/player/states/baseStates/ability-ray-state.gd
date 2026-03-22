extends PlayerBaseState
class_name AbilityRayState

var ability_scene: PackedScene
var ability 
var charge_time: float
	
func physics_process(delta: float) -> int:
	if player.hit:
		return State.Hit
		
	if completed:
		if get_input_vector():
			return State.Run if Input.is_action_pressed("running") else State.Walk
		else:
			return State.Idle
	
	return State.Null 
	
func initialize_state() -> void:
	if not yield(player.wait(charge_time), "completed"): return
	var ability_data: AbilityData = calculate_direction()
	
	if Input.is_action_pressed("kamehameha"):
		ability = ability_scene.instance()
		play_animation(animation + " 2" + ability_data.animation)
		ability.position = player.position + ability.init(player, ability_data.direction, player.direction, player.LAYER, 2)
		Events.emit_signal("add_entity_attack", ability)
		player.continuous_attack_use_energy()
		play_sound()
		yield(Events, "enable_player")
		
	completed = true

func calculate_direction() -> AbilityData:
	var attack_direction: int
	var diagonal_animation: String = ""

	if player.direction8 & 1 == 0:
		attack_direction = player.direction
	else:
		match player.direction8:
			1:
				attack_direction = Direction.Directions.CN3
				diagonal_animation = " Left" if player.direction == Direction.Directions.DOWN else " Down"
			3:
				attack_direction = Direction.Directions.CN4
				diagonal_animation = " Right" if player.direction == Direction.Directions.DOWN else " Down"
			7:
				attack_direction = Direction.Directions.CN1
				diagonal_animation = " Left" if player.direction == Direction.Directions.UP else " Up"
			9:
				attack_direction = Direction.Directions.CN2
				diagonal_animation = " Right" if player.direction == Direction.Directions.UP else " Up"
	
	return AbilityData.new(attack_direction, diagonal_animation)

func play_sound() -> void:
	pass
		
func reset_state() -> void:
	if ability:
		ability.stop()
		ability = null

class AbilityData:
	var direction: int
	var animation: String
	
	func _init(direction: int, animation: String):
		self.direction = direction
		self.animation = animation
