extends ChangeMapState

var direction: int

func _ready():
	animation = 'Fly'
	increase = 150

func setup(direction: int) -> void:
	self.direction = direction

func enter() -> void:
	vector_direction = Direction.get_vector(direction)
	player.sprite.flip_h = Direction.is_right(direction)
	player.sprite.play(animation + " " +  Direction.get_direction_animation(direction))

