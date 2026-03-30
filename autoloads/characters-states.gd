extends Node

static func get_states(character: String) -> Array:
	var states: Dictionary[String, Array] = {
		'goku': [CharacterState.new('kamehameha', 'special_attack_1', PlayerBaseState.State.Kamehameha, 5)],
		'piccolo': [CharacterState.new('SpecialBeamCannon', 'special_attack_1', PlayerBaseState.State.SpecialBeamCannon, 5)],
		'vegeta': [CharacterState.new('FinalFlash', 'special_attack_1', PlayerBaseState.State.FinalFlash, 5)]
	}
	return states.get(character)
