extends PlayerBaseState

class_name MoveState

var vector_direction: Vector2 = Vector2.ZERO
var vector_increase: int = 5000

func input(event: InputEvent) -> int:
	return State.Null

func physics_process(delta: float) -> int:
	if player.hit:
		return State.Hit
		
	movement()
	player.move_and_slide(vector_direction.normalized() * vector_increase * delta)
	if vector_direction == Vector2.ZERO: return State.Idle
	return specific_process()

#ABSTRACT
func specific_process() -> int:
	return State.Null
	
func movement() -> void:
	var new_vector_direction = get_input_vector()
	if new_vector_direction in [Vector2.ZERO, vector_direction]: 
		if new_vector_direction == Vector2.ZERO: vector_direction = Vector2.ZERO
		return
	vector_direction = new_vector_direction
	var angle: float = atan2(vector_direction.y, vector_direction.x) / PI
	var dir4  = [4, 6, 8, 2][player.direction]
	var dir8  = [4, 7, 8, 9, 6, 3, 2, 1][int(round((angle + 1) * 4)) % 8]
	if dir8 & 1 == 0:
		dir4 = dir8
	else:
		var dx = -1 if vector_direction.x < 0 else 1 if vector_direction.x > 0 else 0
		var dy = -1 if vector_direction.y < 0 else 1 if vector_direction.y > 0 else 0
		var directions = [dx + 5, 5 - dy * 3]
		if   dir4 == 10 - directions[0]: dir4 = directions[0]
		elif dir4 == 10 - directions[1]: dir4 = directions[1]
	player.direction8 = dir8
	player.direction = ([0, 0, Direction.Directions.DOWN, 0, Direction.Directions.LEFT, 0, Direction.Directions.RIGHT, 0, Direction.Directions.UP][dir4])
