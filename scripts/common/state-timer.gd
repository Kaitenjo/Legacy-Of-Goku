extends Node2D
class_name StateTimer

signal state_timer_completed(val)
signal set_time_left(val)

var timer: Timer = Timer.new()

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.connect('timeout', wait_completed)
	
func wait(time: float) -> void:
	await Utility.pause(0, 0)
	timer.wait_time = time
	timer.start()
	
func wait_completed() -> void:
	emit_signal('state_timer_completed', true)
	
func state_changed():
	emit_signal('set_time_left', timer.time_left)
	stop()

func stop() -> void:
	timer.stop()
	emit_signal('state_timer_completed', false)
	
func pause():
	timer.paused = true
	
func resume():
	timer.paused = false
