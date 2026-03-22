class_name Direction

enum Directions { LEFT, RIGHT, UP, DOWN, CN1, CN2, CN3, CN4, NONE }
enum Axis { HORIZONTAL, VERTICAL }

static func get_axis(direction: int) -> int:
	return Axis.HORIZONTAL if is_horizontal(direction) else Axis.VERTICAL

static func is_horizontal(direction: int) -> bool:
	return direction in [Directions.LEFT, Directions.RIGHT] 
	
static func is_vertical(direction: int) -> bool:
	return direction in [Directions.UP, Directions.DOWN] 

static func is_right(direction: int) -> bool:
	return direction in [Directions.RIGHT, Directions.CN1, Directions.CN3]
	
static func get_ability_position(positions: Dictionary, character_direction: int, attack_direction: int) -> Vector2:
	return positions.get(character_direction) if character_direction == attack_direction else positions.get(attack_direction).get(get_axis(character_direction))

static func get_vector(direction: int) -> Vector2:
	var vectors := {
		Directions.LEFT: Vector2.LEFT,
		Directions.RIGHT: Vector2.RIGHT,
		Directions.UP: Vector2.UP,
		Directions.DOWN: Vector2.DOWN,
		Directions.CN1: (Vector2.UP + Vector2.LEFT) / sqrt(2),
		Directions.CN2: (Vector2.UP + Vector2.RIGHT) / sqrt(2),
		Directions.CN3: (Vector2.DOWN + Vector2.LEFT) / sqrt(2),
		Directions.CN4: (Vector2.DOWN + Vector2.RIGHT) / sqrt(2),
		Directions.NONE: Vector2.ZERO
	}
	return vectors[direction]

static func get_opposite_vector(direction: int) -> Vector2:
	var vectors := {
		Directions.LEFT: Vector2.RIGHT,
		Directions.RIGHT: Vector2.LEFT,
		Directions.UP: Vector2.DOWN,
		Directions.DOWN: Vector2.UP,
		Directions.CN1: (Vector2.DOWN + Vector2.RIGHT) / sqrt(2),
		Directions.CN2: (Vector2.DOWN + Vector2.LEFT) / sqrt(2),
		Directions.CN3: (Vector2.UP + Vector2.RIGHT) / sqrt(2),
		Directions.CN4: (Vector2.UP + Vector2.LEFT) / sqrt(2),
		Directions.NONE: Vector2.ZERO
	}
	return vectors[direction]
	
static func get_opposite_direction(direction: int) -> int:
	var vectors := {
		Directions.LEFT: Directions.RIGHT,
		Directions.RIGHT: Directions.LEFT,
		Directions.UP: Directions.DOWN,
		Directions.DOWN: Directions.UP,
		Directions.CN1: Directions.CN4,
		Directions.CN2: Directions.CN3,
		Directions.CN3: Directions.CN2,
		Directions.CN4: Directions.CN1,
		Directions.NONE: Directions.NONE
	}
	return vectors[direction]
	
static func get_direction_animation(direction: int, exists_left_animation: bool = false) -> String:
	var vectors := {
		Directions.LEFT: "left" if exists_left_animation else "right",
		Directions.RIGHT: "right",
		Directions.UP: "up",
		Directions.DOWN: "down",
		Directions.CN1: "cn1" if exists_left_animation else "cn2",
		Directions.CN2: "cn2",
		Directions.CN3: "cn3" if exists_left_animation else "cn4",
		Directions.CN4: "cn4",
	}
	return vectors[direction]

static func get_degrees(direction) -> int:
	var vectors := {
		Directions.LEFT: 0,
		Directions.RIGHT: 180,
		Directions.UP: 90,
		Directions.DOWN: 270,
		Directions.CN1: 45,
		Directions.CN2: 135,
		Directions.CN3: 315,
		Directions.CN4: 225,
		Directions.NONE: Vector2.ZERO
	}
	return vectors[direction]
