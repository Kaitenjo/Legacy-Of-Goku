extends Animal
		
func _action_completed() -> void:
	if randi_range(0, 1) == 1:
		set_physics_process(false)
		play_animation("idle")
		await Utility.pause(0.1, 2.1)
		set_physics_process(true)
		
	super()
