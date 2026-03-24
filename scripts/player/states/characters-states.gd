extends Node
class_name CharacterStates

static func get_states(character: String) -> Array:
	var states: Dictionary = {
		'Goku': [CharacterState.new('Kamehameha', 'kamehameha', PlayerBaseState.State.Kamehameha, 5)],
		'Piccolo': [CharacterState.new('SpecialBeamCannon', 'kamehameha', PlayerBaseState.State.SpecialBeamCannon, 5)],
		'Vegeta': [CharacterState.new('FinalFlash', 'kamehameha', PlayerBaseState.State.FinalFlash, 5)]
	}
	return states.get(character)

class Action:
	var action_name: String
	var state: int 
	var energy_used: int
	
	func _init(action_name: String, state: int, energy_used: int = 0):
		self.action_name = action_name
		self.state = state
		self.energy_used = energy_used
		
class CharacterState:
	var action: Action
	var node_script: String
	
	func _init(node_script: String, action_name: String, state: int, energy_used: int = 0):
		self.node_script = node_script
		self.action = Action.new(action_name, state, energy_used)
