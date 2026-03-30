class_name CharacterDTO

var available: bool
var sprite: String
var stats: PlayerStats

func _init(
	available: bool, 
	sprite: String, 
	level := 0, 
	max_health := 0, 
	health := 0, 
	max_energy := 0, 
	energy := 0, 
	attack := 0, 
	power := 0, 
	endurance := 0, 
	shield := 0, 
	exp_next_level := 0, 
	experience := 0, 
	exp_incrase := 0
):
	self.available = available
	self.sprite = sprite
	self.stats = PlayerStats.new(level, max_health, health, max_energy, energy, attack, power, endurance, shield, exp_next_level, experience, exp_incrase) 
	
