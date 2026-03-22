
class_name CharacterDTO

var available: bool
var sprite: String
var stats: PlayerStats

func _init(
	available: bool, 
	sprite: String, 
	level: int = 0, 
	max_health: int = 0, 
	health: int = 0, 
	max_energy: int = 0, 
	energy: int = 0, 
	attack: int = 0, 
	power: int = 0, 
	endurance: int = 0, 
	shield: int = 0, 
	exp_next_level: int = 0, 
	experience: int = 0, 
	exp_incrase: int = 0
):
	self.available = available
	self.sprite = sprite
	self.stats = PlayerStats.new(level, max_health, health, max_energy, energy, attack, power, endurance, shield, exp_next_level, experience, exp_incrase) 
	
