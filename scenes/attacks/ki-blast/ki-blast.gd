extends RigidBody2D
class_name KiBlast

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var body_collision: CollisionShape2D = $Collision
@onready var hitbox: Area2D = $HitBoxArea
@onready var clash: Area2D = $ClashArea

func init(caster: CharacterBody2D, attack_direction: int, character_direction: int, layer: int, power: int) -> Vector2:
	var positions := {
		Direction.Directions.LEFT: Vector2(-10, 2),  
		Direction.Directions.RIGHT: Vector2(10, 2),
		Direction.Directions.UP: Vector2(0, -16), 
		Direction.Directions.DOWN: Vector2(0, 12),
		Direction.Directions.CN1: {
			Direction.Axis.HORIZONTAL: Vector2(-20, -1),
			Direction.Axis.VERTICAL: Vector2(0, -16)
		},
		Direction.Directions.CN2: {
			Direction.Axis.HORIZONTAL: Vector2(20, -1),
			Direction.Axis.VERTICAL: Vector2(0, -16)
		},
		Direction.Directions.CN3: {
			Direction.Axis.HORIZONTAL: Vector2(-20, 5),
			Direction.Axis.VERTICAL: Vector2(0, 12)
		},
		Direction.Directions.CN4: {
			Direction.Axis.HORIZONTAL: Vector2(20, 5),
			Direction.Axis.VERTICAL: Vector2(0, 12)
		}
	}
	
	rotation_degrees = Direction.get_degrees(attack_direction)
	hitbox.init(caster, layer, attack_direction, power, 48, 0.7, 0, AttackArea.Type.Ability)
	sprite.play('default')
	apply_impulse(Vector2(), Direction.get_vector(attack_direction) * 300)
	return Direction.get_ability_position(positions, character_direction, attack_direction)
	
func delete() -> void:
	for node in [body_collision, hitbox, clash]: node.queue_free()
	sleeping = true
	sprite.play('hit')
	rotation_degrees = -90
	await Utility.pause(0.25)
	queue_free()

func _on_KiBlast_body_entered(body: CharacterBody2D) -> void:
	delete()
	
func _on_HitBox_area_entered(area: Area2D) -> void:
	delete()

func _on_Struggle_area_entered(area: Area2D):
	delete()
