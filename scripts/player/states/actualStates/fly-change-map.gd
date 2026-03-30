extends ChangeMapState

var direction: int

func _ready():
	self.animation = 'fly'
	self.increase = 150

func setup(direction: int) -> void:
	self.direction = direction

func enter() -> void:
	self.vector_direction = Direction.get_vector(self.direction)
	self.sprite.flip_h = Direction.is_right(self.direction)
	self.sprite.play(animation + '_' +  Direction.get_direction_animation(self.direction))
