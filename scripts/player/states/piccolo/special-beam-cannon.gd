extends AbilityRayState

func _init():
	self.animation = 'Cannon'
	self.ability_scene = load(Paths.SPECIAL_BEAM_CANNON)
	self.charge_time = 0.55
	
