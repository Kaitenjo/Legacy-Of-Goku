extends BaseEntity
class_name Player

@onready var states_manager: Node = $StatesManager
@onready var hit_wall_area: Area2D = $HitWall
@onready var hit_wall_collision: CollisionShape2D = $HitWall/CollisionShape
@onready var base_attack_area: Area2D = $BaseAttack
@onready var camera: Camera2D = $Camera

const LAYER := 4 #set_collision_mask 0 BASED
var stats: PlayerStats
var hit_wall_positions := {
	Direction.Directions.LEFT: Vector2(-3, 14.5),
	Direction.Directions.RIGHT: Vector2(3, 14.5),
	Direction.Directions.UP: Vector2(0, 13),
	Direction.Directions.DOWN: Vector2(0, 16)
}
var continuous_attack_running := false
var is_energy_rigenerating := false
var is_defense_regenerating := false
var state_unchanged := true
var direction8: int 
var hit := false
var hit_area: AttackArea
var sprite_name: String
var character_name: String
var energy_regen_timer := Timer.new()
var defense_regeneration_timer := Timer.new()
var actions := [
	CharacterStates.Action.new('base_attack', PlayerBaseState.State.BaseAttack),
	CharacterStates.Action.new('ghost_attack', PlayerBaseState.State.FastAttack, 10),
	CharacterStates.Action.new('ki_blast', PlayerBaseState.State.KiBlast, 2),
	CharacterStates.Action.new('teleport', PlayerBaseState.State.Teleport, 20),
	CharacterStates.Action.new('defense', PlayerBaseState.State.Defense)
]
var defense_pose := false
var broke_defense := false
var hit_while_defense := false
var hit_defense_right_direction := true
var shield_activated := false

var shield_scene := preload(Paths.SHIELD)
var shield: AnimatedSprite2D

func load_character(character_name: String, character_data: CharacterDTO):
	self.character_name = character_name
	sprite_name = character_data.sprite
	stats = character_data.stats
		
	var character_states: Array = CharacterStates.get_states(character_name)
	states_manager.load_character_states(self, character_name, character_states)
	
	actions.resize(5)
	for node in character_states:
		actions.append(node.action)
	
	sprite = Utility.load_sprite(character_name + '' + sprite_name)
	play_animation('Stand')
	add_child(sprite)

func init():
	machine_state = states_manager
	machine_state.init(self)
	set_zoom_camera()
	Events.connect('update_zoom_camera', set_zoom_camera)
	#Events.connect('hit', hit)
	#Events.connect('level_up_animation', level_up_animation)
	Events.connect('get_item', get_item)
	Events.connect('send_experience_to_player', update_experience)
	Events.connect('item_used', item_used)
	Events.connect('grab_health_drop', grab_health_drop)
	Events.connect('grab_energy_drop', grab_energy_drop)
	#machine_state.connect('state_changed', state_timer, 'state_changed') 
	for timer in [state_timer, energy_regen_timer, defense_regeneration_timer]:
		add_child(timer)
	energy_regen_timer.wait_time = 5
	energy_regen_timer.one_shot = true
	defense_regeneration_timer.wait_time = 3
	defense_regeneration_timer.one_shot = true
	energy_regeneration()
	
func reset():
	sprite.queue_free()
	
func _input(event: InputEvent) -> void:
	if machine_state:
		machine_state.input(event)

func disable():
	set_process_input(false)
	set_physics_process(false)
	for timer in [energy_regen_timer, defense_regeneration_timer]:
		timer.paused = true
	machine_state.change_state(PlayerBaseState.State.Idle)
	machine_state.emit_signal('state_changed')  #To prevent the afk animation play

func enable():
	set_process_input(true)
	set_physics_process(true)
	for timer in [energy_regen_timer, defense_regeneration_timer]:
		timer.paused = false

func start_change_map(direction: int) -> void:
	start_generic_change_map(direction)

func start_fly_change_map(direction: int) -> void:
	start_generic_change_map(direction, true)

func start_generic_change_map(direction: int, fly: bool = false) -> void:
	var state := PlayerBaseState.State.FlyChangeMap if fly else PlayerBaseState.State.ChangeMap
	set_collision_layer_value(0, false)
	set_collision_mask_value(1, false)
	machine_state.states[state].setup(direction)
	machine_state.change_state(state)
	set_physics_process(true)
	
func end_change_map() -> void:
	end_generic_change_map()

func end_fly_change_map() -> void:
	end_generic_change_map(true)

func end_generic_change_map(fly: bool = false) -> void:
	var state := PlayerBaseState.State.FlyChangeMap if fly else PlayerBaseState.State.ChangeMap
	machine_state.states[state].completed()
	set_physics_process(false)
	set_collision_layer_value(0, true)
	set_collision_mask_value(1, true)
	machine_state.change_state(PlayerBaseState.State.Idle)
	
#Specific method for state base attack
func play_attack_animation(animation: String, backward: bool = false) -> void:
	sprite.flip_h = not exists_left_animation and direction == Direction.Directions.LEFT
	var random_animation := randi_range(1, 3)
	if direction in [Direction.Directions.DOWN, Direction.Directions.UP]:
		sprite.flip_h = Utility.random_int(0, 1)
		random_animation = Utility.random_int(1, 2)
	animation =  animation + '' + str(random_animation) + '' + Direction.get_direction_animation(direction, exists_left_animation)
	sprite.play(animation, backward)
	
#PROPERTY REGION
func set_direction(new_direction: int) -> void:
	var changed = direction != new_direction
	direction = new_direction
	set_hitwall()
	play_animation(machine_state.current_state.animation)
	base_attack_area.set_rotate(direction)
	if changed:
		Events.emit_signal('player_change_direction')
	
func set_hitwall() -> void:
	hit_area.position = hit_wall_positions.get(direction)
	
func enable_hit_wall() -> void:
	hit_wall_collision.call_deferred('set', 'disabled', false)
	
func disable_hit_wall() -> void:
	hit_wall_collision.call_deferred('set', 'disabled', true)

func enable_base_attack() -> void:
	enable_base_attack_hit_box(AttackArea.Type.BaseAttack)
	
func enable_fast_attack() -> void:
	enable_base_attack_hit_box(AttackArea.Type.Ability)

func enable_base_attack_hit_box(type: int) -> void:
	base_attack_area.init(self, LAYER, direction, stats.attack, 35, 0.5, 0, type)
	base_attack_area.enable()

func disable_base_attack() -> void:
	base_attack_area.disable()

func set_zoom_camera() -> void:
	camera.zoom = Settings.zoom_camera

func enable_smoothing() -> void:
	camera.smoothing_enabled = true
	
func disable_smoothing() -> void:
	camera.smoothing_enabled = false

func start_shake() -> void:
	Utility.shake(camera, 'position', camera.position, 0.49, -15, 15)

func stop_shake() -> void:
	Utility.interrupt_shake()
	camera.position = Vector2()

#STATS REGION
func energy_regeneration():
	if is_energy_rigenerating:
		return
		
	is_energy_rigenerating = true
	var recharge_energy: int = ceil(stats.max_energy / 20)
	
	while stats.energy < stats.max_energy:
		energy_regen_timer.start()
		await energy_regen_timer.timeout
		var increase = stats.energy + recharge_energy 
		stats.energy = increase if increase <= stats.max_energy else stats.max_energy
		Events.emit_signal('update_energy', stats.energy)
	
	is_energy_rigenerating = false
	
func set_damage(area: AttackArea) -> void:
	var damage := calculate_damage(area.damage)
	
	if defense_pose:
		update_defense_bar(damage)
	elif shield_activated:
		hit = false
		damage = abs(use_energy(damage))
		if damage: update_defense_bar(damage)
	else:
		update_life_bar(damage)

func calculate_damage(base_damage: int) -> int:
	var damage: int = ceil(2 * pow(base_damage, 2) / (base_damage + stats.endurance)) + ceil(Utility.nextGaussian3(5, 2.7386127875258, 1, 9))
	return 1 if damage < 1 else damage

func update_defense_bar(damage: int) -> void:
	hit_defense_right_direction = hit_area.direction == Direction.get_opposite_direction(direction)
	if not hit_defense_right_direction: 
		update_life_bar(damage)
		return
	
	stats.shield -= damage
	defense_regeneration_timer.stop()
	is_defense_regenerating = false
	
	if stats.shield > 0:
		hit = false
		Events.emit_signal('update_defense', stats.shield)
		Events.emit_signal('show_damage_label', self.position, damage)
		hit_while_defense = true
		await Utility.pause(0.25)
		hit_while_defense = false
	else:
		hit = true
		Events.emit_signal('update_defense', 0)
		broke_defense = true
		update_life_bar(abs(stats.shield))
		stats.shield = 0
			
func update_life_bar(damage: int) -> void:
	if stats.health - damage > 0:
		stats.health -= damage
		Events.emit_signal('show_damage_label', self.position, damage)
	else:
		stats.health = 0
			
	Events.emit_signal('update_health', stats.health)

func defense_regeneration() -> void:
	if is_defense_regenerating or stats.shield == stats.endurance:
		return
		
	is_defense_regenerating = true
	var increase: int = ceil(stats.endurance / 15)
	var recharge_defense := increase if increase > 1 else 1

	while stats.shield < stats.endurance:
		defense_regeneration_timer.start()
		await defense_regeneration_timer.timeout
		var new_shield = stats.shield + recharge_defense 
		stats.shield = new_shield if new_shield <= stats.endurance else stats.endurance
		Events.emit_signal('update_defense', stats.shield)

	is_defense_regenerating = false

func activate_shield() -> void:
	shield_activated = true
	shield = shield_scene.instance()
	add_child(shield)
	shield.play('activating')
	await shield.animation_finished
	shield.play('active')
	drain_energy()
	
func drain_energy() -> void:
	while shield_activated:
		use_energy(1)
		await Utility.pause(0.5)
		
func deactivate_shield() -> void:
	shield.play_backwards('activating')
	await shield.animation_finished
	remove_child(shield)
	shield_activated = false
	
func continuous_attack_use_energy() -> void:
	continuous_attack_running = true
	use_continuous_energy()
	
	await Events.stop_use_energy
	continuous_attack_running = false
	
func use_continuous_energy() -> void:
	await Utility.pause(0) #HANDLE ASYNCRONYSM
	while continuous_attack_running:
		ray_use_energy()
		if not stats.energy:
			Events.emit_signal('stop_continuous_attack')
		await Utility.pause(0.05)
		
	energy_regeneration()

func base_use_energy(val: int) -> void:
	use_energy(val)
	energy_regeneration()
	
func ray_use_energy() -> void:
	use_energy(1)

func use_energy(val: int) -> int:
	var difference := stats.energy - val
	stats.energy = difference if difference >= 0 else 0
	Events.emit_signal('update_energy', stats.energy)
	return 0 if difference >= 0 else difference 
	
func item_used(bonus_stats) -> void:
	update_life_or_energy('health', stats.max_health, bonus_stats.health, 'update_health')
	update_life_or_energy('energy', stats.max_energy, bonus_stats.energy, 'update_energy')
	for stat in ['attack', 'power', 'endurance']:
		stats[stat] += bonus_stats.get(stat)
			
func grab_health_drop(percentage: int) -> void:
	update_life_or_energy('health', stats.max_health, percentage, 'update_health', true)
	
func grab_energy_drop(percentage: int) -> void:
	update_life_or_energy('energy', stats.max_energy, percentage, 'update_energy', true)

func update_life_or_energy(actual_stat: String, max_stat: int, new_value: int, name_signal: String, drop: bool = false) -> void:
	stats[actual_stat] += ceil(max_stat / 100.0 * new_value) if drop else new_value
	if stats[actual_stat] > max_stat or has_underflow_occurred(stats[actual_stat]):
		stats[actual_stat] = max_stat
	Events.emit_signal(name_signal, stats[actual_stat])

func has_underflow_occurred(val: int):
	return val < 1
	
func check_enough_energy(val: float) -> bool:
	if  stats.energy >= val:
		return true
	else:
		AudioManager.play_interface_sound('ActionNotAllowed')
		return false
	
func update_experience(val: int) -> void:
	await Utility.pause(0)
	if stats.experience + val < stats.exp_next_level:
		stats.experience += val
		Events.emit_signal('update_experience', val)
		Events.emit_signal('update_experience_completed')
	else:
		level_up(val)

func level_up(val: int) -> void:
	var increase_attack := 0
	var increase_power := 0
	var increase_endurance := 0
	var increase_health := 0
	var increase_energy := 0
	var new_val := val
	
	while new_val >= stats.exp_next_level - stats.experience:
		new_val -= (stats.exp_next_level - stats.experience)
		
		increase_attack += Utility.random_int(0, 3)
		increase_power += Utility.random_int(0, 3)
		increase_endurance += Utility.random_int(0, 3)
		increase_health += Utility.random_int(1, 5) + ceil(stats.max_health / 20)
		increase_energy += Utility.random_int(1, 5) + ceil(stats.max_energy / 20)
		
		stats.experience = 0
		stats.level += 1
		stats.exp_next_level += 100

	stats.attack += increase_attack
	stats.power += increase_power
	stats.endurance += increase_endurance
	stats.shield = stats.endurance
	stats.max_health += increase_health
	stats.max_energy += increase_energy
	stats.experience += new_val
	
	stats.health = stats.max_health
	stats.energy = stats.max_energy
	
	var in_queue: Array = []
	Events.emit_signal('check_open_level_up', in_queue)
	if in_queue[0]:
		await Events.start_level_up
	
	Events.emit_signal('open_interface', 'LevelUp', [stats.level, stats.experience, stats.exp_next_level, stats.attack, increase_attack, stats.power, increase_power, stats.endurance, increase_endurance, stats.max_health, increase_health, stats.max_energy, increase_energy])
	
	sprite.flip_h = false
	sprite.play('Level Up')
	await sprite.animation_finished
	play_animation('Stand')

func map_entity_scouter() -> ScouterData:
	return ScouterData.new(
		character_name + '' + sprite_name, 
		get_global_transform_with_canvas().origin, 
		'Player', 
		ScouterStats.new(stats.health, stats.attack, stats.power, stats.endurance), 
		sprite.animation, 
		sprite.frame, 
		sprite.flip_h
	)
	
func _on_VerticalHitBox_area_entered(area: AttackArea):
	if not hit:
		Events.emit_signal('disable_actual_entity')
		hit = true
		hit_area = area
		set_damage(area)

func _on_Sight_body_entered(body: CharacterBody2D):
	Events.emit_signal('entity_in_scouter_range', body)

func _on_Sight_body_exited(body: CharacterBody2D):
	Events.emit_signal('entity_out_scouter_range', body)
	
func get_item():
	sprite.flip_h = false
	sprite.play('Grab')

func set_camera_bounds(bounds: CameraBounds):
	camera.limit_left = bounds.left
	camera.limit_right = bounds.right
	camera.limit_bottom = bounds.bottom
	camera.limit_top = bounds.top

class CameraBounds:
	var left := 0
	var right: int  = 0
	var top: int  = 0
	var bottom: int  = 0

	func _init(left := -1000000000, right := 1000000000, top := -1000000000, bottom := 1000000000):
		self.left = left
		self.right = right
		self.top = top
		self.bottom = bottom
