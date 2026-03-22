extends CharacterBody2D
class_name Animal

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

var action_chosen := false
var direction := -1
var actual_vector: Vector2
var speed := 45

func _physics_process(delta: float) -> void:
	if not action_chosen:
		action_chosen = true
		direction = randi_range(0, 3)
		actual_vector = Direction.get_vector(direction)
		play_animation("walk")
		timer.wait_time = randf_range(0.1, 2.1)
		timer.start()
		
	if move_and_collide(actual_vector * speed * delta):
		timer.stop()
		_action_completed()

func play_animation(animation: String) -> void:
	sprite.flip_h = direction == Direction.Directions.LEFT
	sprite.play(animation + "_" + Direction.get_direction_animation(direction))

func _action_completed() -> void:
	action_chosen = false

func _on_timer_timeout() -> void:
	_action_completed()
