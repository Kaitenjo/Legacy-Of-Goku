extends Node
class_name FileManager

static func init() -> void:
	var dir := DirAccess.open('res://')
	
	for path in [Paths.MAPS, Paths.CHARACTERS, Paths.LOCAL, Paths.LOCAL_MAPS, Paths.LOCAL_CHARACTERS]: 
		if not dir.dir_exists(path): dir.make_dir(path)

static func create_game_data() -> void:
	create_save_file(Paths.CHARACTERS + Paths.CHARACTERS_UNLOCKED, GameDB.get_characters_unlocked())
	var characters_data = GameDB.get_characters()
	var areas_data = GameDB.get_areas()
	for character in characters_data.keys(): create_save_file(Paths.CHARACTERS + character, characters_data.get(character))
	for area      in areas_data.keys():      create_save_file(Paths.MAPS + area, areas_data.get(area))
	create_save_file(Paths.MAPS + Paths.WORLD_MAP_FILE, GameDB.get_world_map())
	
static func create_file(path: String, data: Dictionary) -> void:
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_line(JSON.stringify(data))
	file.close()

static func create_save_file(path: String, data: Dictionary) -> void:
	create_file(path + Paths.SAVE_EXTENTION, data)

static func create_settings_file(data: SettingsDTO) -> void:
	var mapped_data: Dictionary = {
		'Audio': {
			'Music': data.audio.music,
			'Sfx': data.audio.sfx
		},
		'Text Speed': data.text_speed,
		'Zoom Camera': data.zoom_camera,
		'Ux': data.ux,
		'Version': data.version
	}
	create_file(Paths.SETTINGS + Paths.CONFIG_EXTENTION, mapped_data)

static func create_update_file() -> void:
	create_file(Paths.UPDATE + Paths.UPDATE_EXTENTION, GameDB.get_updates())
	
static func file_exists(path: String) -> bool:
	return DirAccess.open('res://').file_exists(path)

static func save_file_exists(path: String) -> bool:
	return file_exists(path + Paths.SAVE_EXTENTION)

static func settings_file_exists() -> bool:
	return file_exists(Paths.SETTINGS + Paths.CONFIG_EXTENTION)

static func updates_file_exists() -> bool:
	return file_exists(Paths.UPDATE + Paths.UPDATE_EXTENTION)
	
#---------------------LOAD REGION---------------------
static func load_game_file() -> SaveFile:
	var data = load_save_file(Paths.SAVE)
	var position = data.get('Position')
	var tutorial = data.get('Tutorial')
	var inventory = data.get('Inventory')
	return SaveFile.new(tutorial.get('CheckPoint'), tutorial.get('MapAccessPoint'), data.get('Character'), data.get('Map'), data.get('Area'), position.get('x'), position.get('y'), inventory.get('Equipment'), inventory.get('Keys'), inventory.get('Consumable'))

static func load_character_file(character_name: String) -> CharacterDTO:
	var file_prefix: String = Paths.LOCAL_CHARACTERS if save_file_exists(Paths.LOCAL_CHARACTERS + character_name) else Paths.CHARACTERS
	var data = load_save_file(file_prefix + character_name)
	var stats = data.get('Statistics')
	return GameDB.Character.new(data.get('Available'), data.get('Sprite'), stats.get('Level'), stats.get('Max Health'), stats.get('Health'), stats.get('Max Energy'), stats.get('Energy'), stats.get('Attack'), stats.get('Power'), stats.get('Endurance'), stats.get('Shield'), stats.get('Exp Next Level'), stats.get('Exp'), stats.get('Exp Increase'))

static func load_characters_unlocked_file() -> Dictionary:
	var file_prefix = Paths.LOCAL_CHARACTERS if save_file_exists(Paths.LOCAL_CHARACTERS + Paths.CHARACTERS_UNLOCKED) else Paths.CHARACTERS
	return load_save_file(file_prefix + Paths.CHARACTERS_UNLOCKED)

static func load_area_file(area_name: String) -> Dictionary:
	var file_prefix = Paths.LOCAL_MAPS if save_file_exists(Paths.LOCAL_MAPS + area_name) else Paths.MAPS
	var data = load_save_file(file_prefix + area_name)
	var map_data: Dictionary
	for map in data.keys():
		map_data = data.get(map)
		data[map] = GameDB.Map.new(map_data.get('Actual Event'), map_data.get('Event Occurring'), map_data.get('Items'), map_data.get('Npcs'))
	return data

static func load_world_map_file() -> Dictionary:
	var data = load_save_file(Paths.MAPS + Paths.WORLD_MAP_FILE)
	var area_data: Dictionary
	for area in data:
		area_data = data.get(area)
		data[area] = GameDB.WorldMapArea.new(area_data.get('Unlocked'), area_data.get('Goal'))
	return data
	
static func load_save_file(path: String) -> Dictionary:
	return load_file(path + Paths.SAVE_EXTENTION)
	
static func load_settings_file() -> SettingsDTO:
	var data = load_file(Paths.SETTINGS + Paths.CONFIG_EXTENTION)
	var audio: Dictionary = data.get('Audio')
	return SettingsDTO.new(
		audio.get('Music'), 
		audio.get('Sfx'), 
		data.get('Text Speed'), 
		data.get('Zoom Camera'), 
		data.get('Ux'), 
		data.get('Version')
	) 

static func load_updates_file() -> Dictionary:
	return load_file(Paths.UPDATE + Paths.UPDATE_EXTENTION)
	
static func load_file(path: String) -> Dictionary:
	var file := FileAccess.open(path, FileAccess.READ)
	return JSON.parse_string(file.get_as_text())

#---------------------UPDATE REGION---------------------
static func update_character_file(file: String, character_data: CharacterDTO) -> void:
	var data = {
		'Available': character_data.available,
		'Sprite': character_data.sprite,
		'Statistics': {
			'Level': character_data.stats.level,
			'Max Health': character_data.stats.max_health,
			'Health': character_data.stats.health,
			'Max Energy': character_data.stats.max_energy,
			'Energy': character_data.stats.energy,
			'Attack': character_data.stats.attack,
			'Power': character_data.stats.power,
			'Endurance': character_data.stats.endurance,
			'Shield': character_data.stats.shield,
			'Exp Next Level': character_data.stats.exp_next_level,
			'Exp': character_data.stats.experience,
			'Exp Increase': character_data.stats.exp_incrase
		}
	}
	update_local_file(Paths.LOCAL_CHARACTERS + file, data) 

static func update_characters_unlocked_file(data: Dictionary) -> void:
	update_local_file(Paths.LOCAL_CHARACTERS + Paths.CHARACTERS_UNLOCKED, data)
	
static func update_area_file(file: String, area_data: Dictionary) -> void:
	var dictionary_data = {}
	for map in area_data:
		dictionary_data[map] = {
			'Actual Event': area_data[map].actual_event,
			'Event Occurring': area_data[map].is_event_occurring,
			'Items': area_data[map].items,
			'Npcs': area_data[map].npcs,
		}
	update_local_file(Paths.LOCAL_MAPS + file, dictionary_data)

static func update_local_file(file: String, data: Dictionary) -> void:
	update_save_file(file, data) if save_file_exists(file) else create_save_file(file, data) 

static func update_world_map_file(data: Dictionary) -> void:
	var dictionary_data = {}
	for area in data:
		dictionary_data[area] = {
			'Unlocked': data[area].unlocked,
			'Goal': data[area].goal
		}
	update_save_file(Paths.MAPS + Paths.WORLD_MAP_FILE, dictionary_data)
	
static func update_save_file(path: String, data: Dictionary) -> void:
	delete_save_file(path)
	create_save_file(path, data)

static func update_settings_file(data: SettingsDTO) -> void:
	delete_settings_file()
	create_settings_file(data)

static func save_game(game_data: SaveFile) -> void:
	var data = {
		'Tutorial': {
			'CheckPoint': game_data.tutorial.checkpoint,
			'MapAccessPoint': game_data.tutorial.map_access_point,
		},
		'Character': game_data.character,
		'Map' : game_data.map,
		'Area': game_data.area,
		'Position': {
			'x': game_data.position.x,
			'y': game_data.position.y,
		},
		'Inventory': {
			'Equipment': game_data.inventory.equipment,
			'Keys': game_data.inventory.keys,
			'Consumable': game_data.inventory.consumable,
		}
	}
	update_save_file(Paths.SAVE, data) if save_file_exists(Paths.SAVE) else create_save_file(Paths.SAVE, data)
	
	move_files_from_local(Paths.LOCAL_CHARACTERS, Paths.CHARACTERS)
	move_files_from_local(Paths.LOCAL_MAPS, Paths.MAPS)
		
	var characters_unlocked_path: String = Paths.LOCAL_CHARACTERS + Paths.CHARACTERS_UNLOCKED
	if save_file_exists(characters_unlocked_path):
		update_save_file(Paths.CHARACTERS + Paths.CHARACTERS_UNLOCKED, load_save_file(characters_unlocked_path))

static func move_files_from_local(local_path: String, path: String) -> void:
	var dir := DirAccess.open(local_path)
	var filename: String
	
	dir.list_dir_begin()
	
	while true:
		filename = dir.get_next()
		if filename: dir.copy(local_path + filename, path + filename)
		else: break
	dir.list_dir_end()
	
#---------------------DELETE REGION---------------------
static func delete_game_data() -> void:
	delete_save_file(Paths.SAVE)
	for path in [Paths.CHARACTERS, Paths.MAPS]: delete_all_files_in_folder(path)
		
static func delete_local_files() -> void:
	for path in [Paths.LOCAL_CHARACTERS, Paths.LOCAL_MAPS]: delete_all_files_in_folder(path)
	if save_file_exists(Paths.LOCAL_CHARACTERS + Paths.CHARACTERS_UNLOCKED) : delete_save_file(Paths.LOCAL_CHARACTERS + Paths.CHARACTERS_UNLOCKED)

static func delete_all_files_in_folder(path: String) -> void:
	var dir := DirAccess.open(path)
	var file: String
	
	dir.list_dir_begin()
		
	while true:
		file = dir.get_next()
		if file: dir.remove(file)
		else: break
	dir.list_dir_end()

static func delete_save_file(path: String) -> void:
	delete_file(path + Paths.SAVE_EXTENTION)

static func delete_settings_file() -> void:
	delete_file(Paths.SETTINGS + Paths.CONFIG_EXTENTION)
	
static func delete_file(path: String) -> void:
	DirAccess.open('res://').remove(path)
