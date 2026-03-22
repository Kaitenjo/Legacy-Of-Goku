extends PlayerBaseState

func enter():
	#Calling directly because the Base method would concatenate "Death" and the actual direction, but the death animation is unique
	player.sprite.play("Death")
	Events.emit_signal("death")
