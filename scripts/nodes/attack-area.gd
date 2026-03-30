extends Area2D
class_name AttackArea

enum Type {
	BaseAttack,
	Ability,
	RayAbility
}

@onready var shape: CollisionPolygon2D = $CollisionPolygon2D

var caster: CharacterBody2D
var direction: int
var damage: int
var knockback: float
var time_knockback: float
var tick_damage: float
var type: Type

signal knockback_updated(knockback)

func init(caster: CharacterBody2D, layer: int, direction: int, damage: int, knockback: float, time_knockback := 0, tick_damage := 0, type := 0) -> void:
	self.caster = caster
	self.direction = direction
	self.damage = damage
	self.knockback = knockback
	self.time_knockback = time_knockback
	self.tick_damage = tick_damage
	self.type = type
	self.set_collision_mask_value(layer, true)
 
func enable():
	shape.call_deferred('set', 'disabled', false)

func disable():
	shape.call_deferred('set', 'disabled', true)

func set_rotate(direction: int) -> void:
	rotation_degrees = Direction.get_degrees(direction)
	
func update_knockback(value: float):
	emit_signal('knockback_updated', value)

func clone() -> AttackData:
	return AttackData.new(caster, direction, damage, knockback, time_knockback, tick_damage, type)
