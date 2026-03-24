extends PlayerBaseState

const INCREASE: int = 400

var vector_direction: Vector2 = Vector2.ZERO
var ghost_scene: PackedScene = load(Paths.GHOST_ATTACK)

func _ready():
	animation = 'Attack'
	
func physics_process(delta: float) -> int:
	if player.hit:
		return State.Hit
		
	player.move_and_slide(vector_direction * INCREASE)
	if completed:
		if get_input_vector():
			return State.Run if Input.is_action_pressed('running') else State.Walk
		else:
			return State.Idle
			
	return State.Null
	
func enter() -> void:
	player.play_attack_animation(animation, false)
	player.base_use_energy(10)
	vector_direction = get_direction_vector()
	player.enable_fast_attack()
	
	AudioManager.play_combact_sound('Punch' + str(Utility.random_int(1, 2)))
	var sprite = player.sprite
	for i in range(0, 5):
		Events.emit_signal('add_entity_attack', ghost_scene.instance().init(player.character_name + '/' + player.sprite_name, sprite.animation, sprite.frame, sprite.flip_h, player.position))
		if await player.wait(0.06): return
	
	vector_direction = Vector2.ZERO
	if await player.wait(0.25): return
	completed = true
	
func reset_state():
	player.disable_base_attack()
