extends PlayerBaseState
class_name MoveState

var vector_direction := Vector2.ZERO
var velocity := 5000

func input(event: InputEvent) -> int:
	return State.Null

func physics_process(delta: float) -> int:
	if self.player.hit:
		return State.Hit
		
	self.movement()
	self.move_and_slide(self.vector_direction * delta)
	if self.vector_direction == Vector2.ZERO: return State.Idle
	return self.specific_process()

#ABSTRACT
func specific_process() -> int:
	return State.Null
	
func movement() -> void:
	var new_vector_direction = self.get_input_vector()
	if new_vector_direction in [Vector2.ZERO, self.vector_direction]: 
		if new_vector_direction == Vector2.ZERO: self.vector_direction = Vector2.ZERO
		return
		
	self.vector_direction = new_vector_direction.normalized() * self.velocity 
	var angle := atan2(vector_direction.y, vector_direction.x) / PI
	var dir4  = [4, 6, 8, 2][self.player.direction]
	var dir8  = [4, 7, 8, 9, 6, 3, 2, 1][int(round((angle + 1) * 4)) % 8]
	if dir8 & 1 == 0:
		dir4 = dir8
	else:
		var dx = -1 if self.vector_direction.x < 0 else 1 if self.vector_direction.x > 0 else 0
		var dy = -1 if self.vector_direction.y < 0 else 1 if self.vector_direction.y > 0 else 0
		var directions = [dx + 5, 5 - dy * 3]
		if   dir4 == 10 - directions[0]: dir4 = directions[0]
		elif dir4 == 10 - directions[1]: dir4 = directions[1]
	self.player.direction8 = dir8
	self.player.direction = ([0, 0, Direction.Directions.DOWN, 0, Direction.Directions.LEFT, 0, Direction.Directions.RIGHT, 0, Direction.Directions.UP][dir4])
