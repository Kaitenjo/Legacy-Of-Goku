extends Node2D
class_name Kamehameha

var last_position: Vector2
var enemies_hit := 0
var run_out_of_energy := false

var vector: Vector2
var length := 1
var increase_length: Vector2
const INCREASE := 250
var completed := false
var hitting := false
var colliding := false

var cooldown_explosion := true
var random := RandomNumberGenerator.new()

func init(caster: CharacterBody2D,  attack_direction: int, character_direction: int, layer: int, power: int) -> Vector2:
	Events.connect("stop_continuous_attack", self.out_of_energy)
	var positions := {
		Direction.Directions.LEFT: Vector2(-30, 4),  
		Direction.Directions.RIGHT: Vector2(29.5, 4),
		Direction.Directions.UP: Vector2(-1, -27.5), 
		Direction.Directions.DOWN: Vector2(-0.5, 31),
		Direction.Directions.CN1: {
			Direction.Axis.HORIZONTAL: Vector2(-25, -13),
			Direction.Axis.VERTICAL: Vector2(-15, -23)
		},
		Direction.Directions.CN2: {
			Direction.Axis.HORIZONTAL: Vector2(25, -13),
			Direction.Axis.VERTICAL: Vector2(15, -23)
		},
		Direction.Directions.CN3: {
			Direction.Axis.HORIZONTAL: Vector2(-22, 22),
			Direction.Axis.VERTICAL: Vector2(-16, 25)
		},
		Direction.Directions.CN4: {
			Direction.Axis.HORIZONTAL: Vector2(22, 22),
			Direction.Axis.VERTICAL: Vector2(16, 25)
		}
	}
	vector = Direction.get_vector(attack_direction) * INCREASE
	rotation_degrees = Direction.get_degrees(attack_direction)
	$Body/HeadArea.init(caster, layer, attack_direction, power, 25, 0, 0.1, AttackArea.Type.RayAbility)
	$Body/BodyArea.init(caster, layer, attack_direction, power, 36, 0, 0.1, AttackArea.Type.RayAbility)
	play_sound()
	return Direction.get_ability_position(positions, character_direction, attack_direction)

func play_sound() -> void:
	await Utility.pause(0, 0)
	AudioManager.play_combact_sound("KamehamehaFire")
	await Utility.pause(2.44)
	AudioManager.play_combact_sound("KamehamehaLoop")

func _physics_process(delta: float) -> void:
	if not completed:
		if Input.is_action_pressed("kamehameha") and not run_out_of_energy:
			last_position = $Body.position
			increase_length = vector * delta
					
			if not colliding:
				length += get_increase()
				$Body/Body.region_rect = Rect2(0, 0, length, 6)
				$Body/BodyArea.scale.x += get_increase()
				$Body/BodyArea.position.x = 8 + $Body/BodyArea.scale.x/2
						
			if not colliding and $Body.move_and_collide(increase_length):
				colliding = true
				$Body/Collision.disabled = true
				$Body.position = last_position
				cooldown_explosion = true
		else:
			stop()
			Events.emit_signal("enable_player")
	else:
		increase_length = vector * delta
		length -= get_increase()
		$Body/Body.region_rect = Rect2(0, 0, length, 6)
		$Body/BodyArea.scale.x -= get_increase()
		$Body/BodyArea.position.x = 8 + $Body/BodyArea.scale.x/2
				
		if length < get_increase():
			AudioManager.stop_combact_sound("KamehamehaFire")
			AudioManager.stop_combact_sound("KamehamehaLoop")
			$Body/Head.visible = false
			queue_free()

	if hitting or colliding:
		collided_kamehameha()
			
func _on_HeadArea_area_entered(_area: Area2D) -> void:
	enemies_hit += 1
	if not hitting:
		hitting = true
		vector /= 10

func _on_HeadArea_area_exited(_area: Area2D) -> void:
	enemies_hit -= 1
	
	if !enemies_hit:
		hitting = false
		
		for child in get_children():
			if child.is_in_group("Explosion"):
				child.queue_free()
				
		vector *= 10
		
func collided_kamehameha() -> void:
	$Body/Head.play("Hit")
	
	if cooldown_explosion:
		$CooldownExplosion.start()
		cooldown_explosion = false
		random.randomize()
		Events.emit_signal("show_explosion", $Body/Head.global_position  + Vector2(random.randf_range(-15, 15), random.randf_range(-15, 15)))

func get_increase() -> float:
	if increase_length.x and increase_length.y: return abs(increase_length.x * sqrt(2))
	return abs(increase_length.x if increase_length.x else increase_length.y)
	
func update_knockback():
	$Body/HeadArea.update_knockback(0)

func stop():
	completed = true
	if hitting:
		vector *= 10
		hitting = false
	if self.has_node("Tail"): $Tail.queue_free()
	Events.emit_signal("stop_use_energy")
	update_knockback()
			
func _on_CooldownExplosion_timeout() -> void:
	cooldown_explosion = true

func out_of_energy() -> void:
	run_out_of_energy = true
