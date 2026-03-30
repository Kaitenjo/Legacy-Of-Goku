extends Node2D
class_name StateTimer

var timer := Timer.new()

signal state_timer_completed(val)
signal set_time_left(val)

func _ready():
	self.timer = Timer.new()
	self.add_child(timer)
	self.timer.one_shot = true
	self.timer.connect('timeout', wait_completed)
	
func wait(time: float) -> void:
	await Utility.pause(0, 0)
	self.timer.wait_time = time
	self.timer.start()
	
func wait_completed() -> void:
	self.emit_signal('state_timer_completed', true)
	
func state_changed():
	self.emit_signal('set_time_left', timer.time_left)
	self.stop()

func stop() -> void:
	self.timer.stop()
	self.emit_signal('state_timer_completed', false)
	
func pause():
	self.timer.paused = true
	
func resume():
	self.timer.paused = false
