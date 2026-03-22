extends Animal

func _ready() ->  void:
	speed = 100

func  play_animation(name_animation: String) -> void:
	sprite.flip_h = direction == Direction.Directions.LEFT
	
	var direction_animation = Direction.get_direction_animation(direction)
	match direction_animation:
		'right':
			direction_animation = 'left'
			pass
		'down':
			direction_animation = 'up'
			pass
			
	sprite.play(name_animation + "_" + direction_animation)
