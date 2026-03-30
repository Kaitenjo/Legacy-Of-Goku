class_name ScouterData

var name: String
var position: Vector2
var type: String
var stats: ScouterStats
var animation: String
var frame: int
var flip_h: bool
var display_info: DisplayInfo
var animate: bool

func _init(name: String, position: Vector2, type: String, stats: ScouterStats, animation: String, frame: int, flip_h: bool, animate := true):
	self.name = name
	self.position = position
	self.type = type
	self.stats = stats
	self.animation = animation
	self.frame = frame
	self.flip_h = flip_h
	self.display_info =  ComputerInfo.get_display_info(name)
	self.animate = animate
