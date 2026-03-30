extends Node

var resolution: Vector2
var text_speed: float
var zoom_camera: Vector2
var ux: bool

var DEFAULT_SETTINGS := SettingsData.new(4, 4, 4, 8, false, 1)

func _ready() -> void:
	Events.connect('zoom_camera_value_changed', update_zoom_camera)
	Events.connect('text_speed_value_changed', update_text_speed)
	resolution = DisplayServer.window_get_size() / Vector2i(1360, 768)
	if not FilesSystemManager.settings_file_exists():  FilesSystemManager.create_settings_file(DEFAULT_SETTINGS)
	var new_settings := FilesSystemManager.load_settings_file()
	update_text_speed(new_settings.text_speed)
	update_zoom_camera(new_settings.zoom_camera)
	update_ux(new_settings.ux)

func update_text_speed(val: int) -> void:
	text_speed = 5 * 0.01 / (val + 1)

func update_zoom_camera(val: int) -> void:
	var decrease = (Vector2(0.4, 0.4) - Vector2(0.2, 0.2))/(8 * resolution)
	zoom_camera =  Vector2(0.4, 0.4)/resolution - (8 - val) * decrease
	Events.emit_signal('update_zoom_camera')

func update_ux(val: bool):
	ux = val
	Events.emit_signal('update_ux', val)
