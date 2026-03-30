class_name CharacterState

var action: Action
var node_script: String

func _init(node_script: String, action_name: String, state: int, energy_used := 0):
	self.node_script = node_script
	self.action = Action.new(action_name, state, energy_used)
