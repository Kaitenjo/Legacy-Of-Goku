extends Node
class_name BaseState

var animation: String
var completed := false
var time_left := 0

func _init():
	pass
	
func enter() -> void:
	play_animation(animation)
	initialize_state()

func initialize_state() -> void:
	pass

func exit() -> void:
	completed = false
	time_left = 0
	reset_state()

func reset_state() -> void:
	pass
	
func process(delta: float) -> int:
	return 0

func physics_process(delta: float) -> int:
	return 0
	
func play_animation(animation: String) -> void:
	pass
