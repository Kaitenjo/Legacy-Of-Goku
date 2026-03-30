class_name AttackData

var caster: CharacterBody2D
var direction: int
var damage: int
var knockback: float
var time_knockback: float
var tick_damage: float
var type: int

func _init(caster: CharacterBody2D, direction: int, damage: int, knockback: float, time_knockback := 0, tick_damage := 0, type := 0):
	self.caster = caster
	self.direction = direction
	self.damage = damage
	self.knockback = knockback
	self.time_knockback = time_knockback
	self.tick_damage = tick_damage
	self.type = type
