extends PlayerBaseState

const VELOCITY := 400

var vector_direction: Vector2 = Vector2.ZERO
var ghost_scene: PackedScene

func _ready():
	self.animation = 'attack'
	
func physics_process(delta: float) -> int:
	if self.player.hit:
		return State.Hit
	
	self.move_and_slide(self.vector_direction * self.VELOCITY)
	if self.completed:
		if self.get_input_vector():
			return State.Run if Input.is_action_pressed('running') else State.Walk
		else:
			return State.Idle
			
	return State.Null
	
func enter() -> void:
	self.player.play_attack_animation(animation, false)
	self.player.base_use_energy(10)
	self.vector_direction = self.get_direction_vector()
	self.player.enable_fast_attack()
	
	AudioManager.play_combact_sound('Punch' + str(Utility.random_int(1, 2)))
	var sprite_name = self.player.character_name + '/' + self.player.sprite_name
	
	for i in range(0, 5):
		Events.emit_signal('add_entity_attack', self.ghost_scene.instance().init(sprite_name, self.sprite.animation, self.sprite.frame, self.sprite.flip_h, self.player.position))
		if await self.player.wait(0.06): return
	
	self.vector_direction = Vector2.ZERO
	if await self.player.wait(0.25): return
	self.completed = true
	
func reset_state():
	self.player.disable_base_attack()
