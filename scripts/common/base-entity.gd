extends CharacterBody2D
class_name BaseEntity

var sprite: AnimatedSprite2D
var direction: int = Direction.Directions.DOWN:
	set(value): set_direction(value)
	get: return get_direction()
	
var exists_left_animation: bool = false 
var machine_state: Node
var state_timer: StateTimer = StateTimer.new()
var time_left: float = 0

func _ready():
	state_timer.connect('set_time_left', set_time_left)

func _physics_process(delta: float) -> void:
	if machine_state:
		machine_state.physics_process(delta)
	
func set_direction(new_direction: int) -> void:
	pass

func get_direction() -> int:
	return direction

func play_animation(animation: String, backward: bool = false) -> void:
	sprite.flip_h = not exists_left_animation and direction == Direction.Directions.LEFT
	animation = animation + ' ' + Direction.get_direction_animation(direction, exists_left_animation)
	sprite.play(animation, backward)

func wait(time: float) -> bool:
	state_timer.wait(time)
	return await state_timer.state_timer_completed

func set_time_left(time_left: float) -> void:
	self.time_left = time_left
	
class PathMovement:
	var vector: Vector2
	var direction: int
	var time: float
	var increase: int

	func _init(direction: int, vector: Vector2 = Vector2.ZERO, increase: int = 0, time: float = 0) -> void:
		self.vector = vector
		self.direction = direction
		self.increase = increase
		self.time = time

class ScouterData:
	var name: String
	var position: Vector2
	var type: String
	var stats: ScouterStats
	var animation: String
	var frame: int
	var flip_h: bool
	var display_info: DisplayInfo
	var animate: bool
	
	func _init(name: String, position: Vector2, type: String, stats: ScouterStats, animation: String, frame: int, flip_h: bool, animate: bool = true):
		self.name = name
		self.position = position
		self.type = type
		self.stats = stats
		self.animation = animation
		self.frame = frame
		self.flip_h = flip_h
		self.display_info =  ComputerInfo.get_display_info(name)
		self.animate = animate
