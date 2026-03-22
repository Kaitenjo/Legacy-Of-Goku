class_name SaveFile

var tutorial: Tutorial 
var character: String
var map: String
var area: String
var position: Vector2
var inventory: Inventory

func _init(checkpoint: bool, map_access_point: bool, character: String, map: String, area: String, x: float, y: float, equipment: Dictionary, keys: Dictionary, consumable: Dictionary):
	self.tutorial = Tutorial.new(checkpoint, map_access_point)
	self.character = character
	self.map = map
	self.area = area
	self.position = Vector2(x, y)
	self.inventory = Inventory.new(equipment, keys, consumable)
