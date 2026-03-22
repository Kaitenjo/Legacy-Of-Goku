class_name PlayerStats

var level: int
var max_health: int
var health: int
var max_energy: int
var energy: int
var attack: int
var power: int
var endurance: int
var shield: int
var exp_next_level: int
var experience: int
var exp_incrase: int

func _init(
	level: int, 
	max_health: int, 
	health: int, 
	max_energy: int, 
	energy: int, 
	attack: int, 
	power: int, 
	endurance: int, 
	shield: int, 
	exp_next_level: int, 
	experience: int, 
	exp_incrase
):
	self.level = level 
	self.max_health = max_health 
	self.health = health 
	self.max_energy = max_energy 
	self.energy = energy 
	self.attack = attack 
	self.power = power 
	self.endurance = endurance 
	self.shield = shield
	self.exp_next_level = exp_next_level 
	self.experience = experience 
	self.exp_incrase = exp_incrase 
