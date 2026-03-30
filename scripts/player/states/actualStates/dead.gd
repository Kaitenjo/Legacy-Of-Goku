extends PlayerBaseState

func enter():
	#Calling directly because the Base method would concatenate 'Death' and the actual direction, but the death animation is unique
	self.sprite.play('death')
	Events.emit_signal('death')
