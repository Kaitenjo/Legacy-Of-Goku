extends AbilityRayState

func _init() -> void:
	animation = 'Final Flash'
	ability_scene = load(Paths.FINAL_FLASH)
	charge_time = 0.36

func initialize_state() -> void:
	var direction_data: AbilityRayState.AbilityData = calculate_direction()
	ability = ability_scene.instance()
	ability.position = player.position + ability.init(player, direction_data.direction,  player.direction, player.LAYER, 2)
	Events.emit_signal('check_collision_final_flash', ability.position, ability.collision_size, direction_data.direction)
	ability.set_max_length(yield(Events, 'send_collision_final_flash'))
	
	if not yield(player.wait(charge_time), 'completed'): return
	
	if Input.is_action_pressed('kamehameha'):
		play_animation(animation + ' 2' + direction_data.animation)
		Events.emit_signal('add_entity_attack', ability)
		player.continuous_attack_use_energy()
		yield(Events, 'enable_player')
	completed = true
