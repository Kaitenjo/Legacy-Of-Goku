class_name Inventory

var equipment: Dictionary
var keys: Dictionary
var consumable: Dictionary

func _init(equipment: Dictionary = {}, keys: Dictionary = {}, consumable: Dictionary = {}):
	self.equipment = equipment
	self.keys = keys
	self.consumable = consumable

func is_empty() -> bool:
	return equipment.is_empty() and keys.is_empty() and consumable.is_empty()

func clone() -> Inventory:
	return Inventory.new(equipment.duplicate(true), keys.duplicate(true), consumable.duplicate(true))
