class_name PathMovement

var vector: Vector2
var direction: int
var time: float
var increase: int

func _init(direction: int, vector := Vector2.ZERO, increase := 0, time := 0) -> void:
	self.vector = vector
	self.direction = direction
	self.increase = increase
	self.time = time
