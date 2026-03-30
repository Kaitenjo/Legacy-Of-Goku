class_name Action

var action_name: String
var state: int 
var energy_used: int

func _init(action_name: String, state: int, energy_used := 0):
	self.action_name = action_name
	self.state = state
	self.energy_used = energy_used
