extends CharacterBody2D
class_name BaseEntity

var sprite: AnimatedSprite2D

var _direction: Direction.Directions
var direction := Direction.Directions.DOWN:
	set(value): set_direction(value)
	get: return get_direction()

var exists_left_animation := false 
var machine_state: Node
var state_timer := StateTimer.new()
var time_left := 0

func _ready():
	self.state_timer.connect('set_time_left', set_time_left)
	
func _physics_process(delta: float) -> void:
	self.machine_state.physics_process(delta)
	
func set_direction(new_direction: int) -> void:
	pass

func get_direction() -> int:
	return self._direction

func play_animation(animation: String, backward := false) -> void:
	self.sprite.flip_h = not exists_left_animation and not Direction.is_right(direction)
	animation = animation + '_' + Direction.get_direction_animation(direction, exists_left_animation)
	self.sprite.play(animation, -1 if backward else 1)
	
func wait(time: float) -> bool:
	self.state_timer.wait(time)
	return await self.state_timer.state_timer_completed

func set_time_left(time_left: float) -> void:
	self.time_left = time_left
