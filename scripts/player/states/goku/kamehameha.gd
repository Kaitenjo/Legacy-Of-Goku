extends AbilityRayState

func _init():
	self.animation = 'kame'
	self.ability_scene = load(Paths.KAMEHAMEHA)
	self.charge_time = 0.5
