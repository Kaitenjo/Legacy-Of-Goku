extends AbilityRayState

func _init():
	animation = 'Cannon'
	ability_scene = load(Paths.SPECIAL_BEAM_CANNON)
	charge_time = 0.55
	
