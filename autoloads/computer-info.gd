extends Node

var NPC_DATA := {
	'Chichi/Classic': ScouterStats.new(0, 0, 0, 0),
	'Turtle/Classic': ScouterStats.new(0, 0, 0, 0),
	'Gohan/Kid': ScouterStats.new(0, 0, 0, 0),
	'Krilin/Classic': ScouterStats.new(0, 0, 0, 0),
	'Bulma/Classic': ScouterStats.new(0, 0, 0, 0),
	'MasterRoshi/RaditzSaga': ScouterStats.new(0, 0, 0, 0),
	'Raditz/Classic': ScouterStats.new(1000, 50, 60, 35),
	'Popo/Classic': ScouterStats.new(830, 14, 40, 25),
	'Kami/Classic': ScouterStats.new(1130, 20, 45, 16),
	'Korin/Classic': ScouterStats.new(3470, 25, 59, 43)
}

var DISPLAY_DATA := {
	'Snake': DisplayInfo.new('', false),
	'Wolf': DisplayInfo.new('', false),
	'Eagle': DisplayInfo.new('', false),
	'Tigerman': DisplayInfo.new('', false),
	'T-Rex': DisplayInfo.new('', false),
	'Goku/Classic': DisplayInfo.new(),
	'Piccolo/Classic': DisplayInfo.new(),
	'Vegeta/Android': DisplayInfo.new(),
	'Chichi/Classic': DisplayInfo.new(),
	'Turtle/Classic': DisplayInfo.new(),
	'Gohan/Kid': DisplayInfo.new(),
	'Krilin/Classic': DisplayInfo.new(),
	'Bulma/Classic': DisplayInfo.new(),
	'MasterRoshi/RaditzSaga': DisplayInfo.new(),
	'Raditz/Classic': DisplayInfo.new(),
	'Popo/Classic': DisplayInfo.new(),
	'Kami/Classic': DisplayInfo.new(),
	'Korin/Classic': DisplayInfo.new()
}

func get_npc_stats_data(npc_name: String) -> ScouterStats:
	return NPC_DATA.get(npc_name)

func get_display_info(entity_name) -> DisplayInfo:
	return DISPLAY_DATA.get(entity_name)
