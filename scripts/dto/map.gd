class_name Map

var actual_event: int
var is_event_occurring: bool
var items: Dictionary
var npcs: Dictionary

func _init(actual_event: int, is_event_occurring: bool, items: Dictionary = {}, npcs: Dictionary = {}):
	self.actual_event = actual_event
	self.is_event_occurring = is_event_occurring
	self.items = items
	self.npcs = npcs
