extends Node
class_name BaseState

var animation: String
var completed := false
var time_left := 0

func _init():
	pass
	
func process(delta: float) -> int:
	return 0

func physics_process(delta: float) -> int:
	return 0
	
func enter() -> void:
	self.play_animation(animation)
	self.initialize_state()

func initialize_state() -> void:
	pass

func exit() -> void:
	self.completed = false
	self.time_left = 0
	self.reset_state()

func reset_state() -> void:
	pass
	
func play_animation(animation: String) -> void:
	pass
