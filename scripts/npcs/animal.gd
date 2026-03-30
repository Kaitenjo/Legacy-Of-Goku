extends CharacterBody2D
class_name Animal

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

var action_chosen := false
var direction := -1
var actual_vector: Vector2
var speed := 45

func _physics_process(delta: float) -> void:
	if not self.action_chosen:
		self.action_chosen = true
		self.direction = randi_range(0, 3)
		self.actual_vector = Direction.get_vector(direction)
		self.play_animation('walk')
		self.timer.wait_time = randf_range(0.1, 2.1)
		self.timer.start()
		
	if move_and_collide(actual_vector * speed * delta):
		self.timer.stop()
		self._action_completed()

func play_animation(animation: String) -> void:
	self.sprite.flip_h = Direction.is_right(direction)
	self.sprite.play(animation + '_' + Direction.get_direction_animation(direction))

func _action_completed() -> void:
	self.action_chosen = false

func _on_timer_timeout() -> void:
	self._action_completed()
