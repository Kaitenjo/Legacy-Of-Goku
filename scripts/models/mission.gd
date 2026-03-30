class_name MissionDTO

var items: Array[String]
var npcs: Array[String]

func _init(items: Array[String], npcs := []):
	self.items = items
	self.npcs = npcs
