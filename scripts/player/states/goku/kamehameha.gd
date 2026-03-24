extends AbilityRayState

func _init():
	animation = 'Kame'
	ability_scene = load(Paths.KAMEHAMEHA)
	charge_time = 0.5
