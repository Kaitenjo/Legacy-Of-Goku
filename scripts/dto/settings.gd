class_name SettingsDTO

var audio: Audio
var text_speed: int
var zoom_camera
var ux: bool
var version: int

func _init(music: int, sfx: int, text_speed: int, zoom_camera: int, ux: bool, version: int = 0):
	self.audio = Audio.new(music, sfx)
	self.text_speed = text_speed
	self.zoom_camera = zoom_camera
	self.ux = ux
	self.version = version
