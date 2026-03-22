extends Node

func _ready() -> void:
	if not FileManager.updates_file_exists(): FileManager.create_update_file()
		
	var data = FileManager.load_updates_file()
	var settings = FileManager.load_settings_file()
	for i in range(settings.get("version"), data.keys().size()):
		settings["version"] += 1
		var current_data = data.get(str(i))
		for area in current_data.keys():
			var area_data = FileManager.load_save_file(Paths.MAPS + area)
			if area_data:
				var current_area_data = current_data.get(area)
				for map in current_area_data.keys():
					var current_map = current_area_data.get(map)
					if not data.has(map): area_data[map] = current_map
					else:
						for value in current_map.keys():
							area_data[map][value] = current_map.get(value)
			FileManager.update_save_file(Paths.MAPS + area, area_data)
		
	FileManager.update_settings_file(settings)
