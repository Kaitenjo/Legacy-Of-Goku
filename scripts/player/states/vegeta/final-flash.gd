extends AbilityRayState

func _init() -> void:
	self.animation = 'Final Flash'
	self.ability_scene = load(Paths.FINAL_FLASH)
	self.charge_time = 0.36

func initialize_state() -> void:
	var direction_data := calculate_direction()
	self.ability = self.ability_scene.instance()
	self.ability.position = self.player.position + self.ability.init(self.player, self.direction_data.direction,  self.player.direction, self.player.LAYER, 2)
	Events.emit_signal('check_collision_final_flash', self.ability.position, self.ability.collision_size, self.direction_data.direction)
	self.ability.set_max_length(await Events.send_collision_final_flash)
	
	if not await self.player.wait(self.charge_time): return
	
	if Input.is_action_pressed('kamehameha'):
		self.play_animation(self.animation + '_2' + direction_data.animation)
		Events.emit_signal('add_entity_attack', self.ability)
		self.player.continuous_attack_use_energy()
		await Events.enable_player
	completed = true
