#extends Node
#
#var player: Player = load(Paths.PLAYER).instance()
#var world_map: WorldMap = load(Paths.WORLD_MAP).instance()
#
#var game_data: GameData.SaveFile
#var character_data: GameData.Character
#var area_data: Dictionary = {}
#var actual_map: BaseMap
#var entities_handler: EntitiesHandler
#var area: String = ""
#var zone: String = ""
#var original_sprite_position: Vector2
#
#func _ready() -> void:
	#Events.connect("update_state_item", self, "update_state_item")
	#Events.connect("update_state_mission", self, "update_state_mission")
	#Events.connect("enter_world_map", self, "enter_world_map")
	#Events.connect("platform_change_map", self, "platform_change_map")
	#Events.connect("change_map", self, "leave_map_walking")
	#Events.connect("update_maps", self, "update_maps")
	#Events.connect("update_npc_events", self, "update_npc_events")
	#Events.connect("unlock_character", self, "unlock_character")
	#Events.connect("exit_world_map", self, "exit_world_map")
	#Events.connect("ask_is_world_map_actual_map", self, "is_world_map_actual_map")
	#Events.connect("save_game", self, "save_game")
	#Events.connect("close_dialogue_box", self, "close_dialogue_box")
	#Events.connect("load_character", self, "load_character")
	#Events.connect("update_tutorial_data", self, "update_tutorial_data")
	#Events.connect("back_to_title_screen", self, "back_to_title_screen")
	#Events.connect("ask_player_stats", self, "get_player_stats")
	#Events.connect("show_zone", self, "show_zone")
	#Events.connect("start_cutscene_post_event", self, "cutscene_handler")
	#Events.connect("remove_player", self, "remove_player")
	#Events.connect("ask_actual_area", self, "ask_actual_area")
	#Events.connect("death", self, "game_over")
	#
	#game_data = FileManager.load_game_file() if FileManager.save_file_exists(Paths.SAVE) else GameData.get_new_save_file()
	#character_data = FileManager.load_character_file(game_data.character)
	#load_character(game_data.character, true)
	#player.init()
	#$Gui.init(game_data.tutorial, game_data.inventory)
	#var last_map = game_data.map
	#
	#set_area(game_data.area)
	#set_map(last_map)
	#
	#var last_map_data: GameData.Map = area_data.get(last_map)
#
	#if not actual_map.is_cutscene_event(last_map_data.is_event_occurring, last_map_data.actual_event):
		#actual_map.load_map(last_map_data)
		#player.position = game_data.position
		#entities_handler.add_child(player)
		#$Gui.move_on_screen()
		#yield($Gui.show_transition(), "completed")
		#$Gui.enable_menu()
	#else:
		#cutscene_handler(actual_map.get_event(last_map_data.actual_event))
#
#func set_area(new_area: String) -> void:
	#if area != new_area:
		#if area: FileManager.update_area_file(area, area_data)
		#area = new_area
		#area_data = FileManager.load_area_file(new_area)
		#
#func set_map(map_name: String, payload: Dictionary = {}) -> void:
	#if actual_map: actual_map.queue_free()
	#actual_map = load(Paths.MAPS_FOLDER + Paths.KEY_TO_SCENE[area]["Folder"] + Paths.KEY_TO_SCENE[area][map_name] + ".tscn").instance()
	#actual_map.payload = payload
	#set_camera_bounds()
	#entities_handler = actual_map.get_node("YSort")
	#add_child(actual_map)
#
#func is_world_map_actual_map():
	#yield(Utility.pause(0), "completed")
	#Events.emit_signal("response_is_world_map_actual_map", world_map.is_inside_tree())
	#
#func set_camera_bounds() -> void:
	#player.set_camera_bounds(actual_map.camera_bounds)
#
#func show_zone() -> void:
	#var new_zone: String = actual_map.zone if actual_map else world_map.zone
	#if new_zone != zone:
		#zone = new_zone
		#$Gui.open_interface("NameZone", zone)
		#
#func leave_map_walking(new_map: String, position: Vector2, direction: int, new_direction = null, payload: Dictionary = {}) -> void:
	#$Gui.level_up_in_queue = true
	#$Gui.disable_menu()
	#entities_handler.disable_entities()
	#player.start_change_map(direction)
	#yield($Gui.fade_transition(), "completed")
	#entities_handler.remove_child(player)
	#set_map(new_map, payload)
	#
	#var last_map: GameData.Map = area_data.get(actual_map.map_name)
#
	#if not actual_map.is_cutscene_event(last_map.is_event_occurring, last_map.actual_event):
		#actual_map.load_map(last_map)
		#enter_map_walking(position, new_direction if new_direction else direction)
	#else: 
		#yield(cutscene_handler(actual_map.get_event(last_map.actual_event)), "completed")
		#$Gui.level_up_in_queue = false
		#
#func enter_map_walking(position: Vector2, direction: int) -> void:
	#player.position = position
	#entities_handler.add_child(player)
	#player.start_change_map(direction)
	#yield($Gui.show_transition(), "completed")
	#player.end_change_map()
		#
	#yield(Utility.pause(0.1), "completed")
	#entities_handler.enable_player()
#
	#yield(Utility.pause(0.15), "completed")
	#
	#$Gui.enable_menu()
	#$Gui.level_up_in_queue = false
	#Events.emit_signal("start_level_up")
#
#func cutscene_handler(event: CutsceneEvent) -> void:
	#var completed: bool = false
	#
	#var cutscene_info: CutsceneEvent.CutsceneInfo = event.get_start_info()
	#yield(start_cutscene(cutscene_info), "completed")
	#yield(event.exec(CutsceneEvent.PlayerInfo.new(player.position, player.sprite.animation, player.sprite.flip_h)), "completed") if cutscene_info.get_type() == "playing" and not cutscene_info.fade_transition() else yield(event.exec(), "completed")
	#
	#while not completed:
		#cutscene_info = event.get_end_info()
		#if cutscene_info.get_type() == "ending":
			#completed = true
			#end_cutscene(cutscene_info)
		#else:
			#yield(start_cutscene(cutscene_info), "completed")
			#event = actual_map.get_event(area_data[actual_map.map_name].actual_event)
			#yield(event.exec(), "completed")
			#
#func start_cutscene(info: CutsceneEvent.CutsceneInfo) -> void:
	#match info.get_type():
		#"entering":
			#player.end_change_map()
			#if not info.is_this_map():
				#set_area(info.get_new_area())
				#set_map(info.get_new_map())
			#yield($Gui.move_off_screen(), "completed")
#
		#"playing":
			#$Gui.level_up_in_queue = true
			#$Gui.disable_menu()
			#$Gui.move_off_screen()
			#entities_handler.disable_entities()
			#
			#if info.is_this_map():
				#yield(Utility.pause(0), "completed")
				#if info.fade_transition():
					#yield($Gui.fade_transition(), "completed")
				#player.visible = false
			#else:
				#yield($Gui.fade_transition(), "completed")
				#remove_player()
				#set_area(info.get_new_area())
				#set_map(info.get_new_map())
				#
		#"continue":
				#yield($Gui.fade_transition(), "completed")
				#set_area(info.get_new_area())
				#set_map(info.get_new_map())
#
#func remove_player() -> void:
	#entities_handler.remove_child(player)
	#
#func end_cutscene(info: CutsceneEvent.CutsceneEndInfo) -> void:
	#if not info.is_this_map():
		#yield($Gui.fade_transition(), "completed")
		#set_area(info.get_new_area())
		#set_map(info.get_new_map())
		#
	#player.position = info.get_position()
	#player.direction = info.get_direction()
	#player.play_animation("Stand")
	#player.get_node("Camera").current = true
	#player.disable_smoothing()
	#player.visible = true #utile nel caso finisca una cutscene triggerata da un'entrata in una mappa, la cui azione mette il giocatore invisibile
	#entities_handler.add_child(player)
	#
	#if not info.is_this_map(): yield($Gui.show_transition(), "completed")
#
	#$Gui.move_on_screen()
	#$Gui.enable_menu()
	#entities_handler.enable_player()
	#player.enable_smoothing()
	#var map_data = area_data[actual_map.map_name]
	#actual_map.load_map(map_data)
	#
#func platform_change_map(new_map: String, target: int, movements: Array, new_position: Vector2):
	#$Gui.level_up_in_queue = true
	#$Gui.disable_menu()
	#entities_handler.disable_entities()
	#
	#for movement in movements:
		#player.start_fly_change_map(movement.direction)
		#yield(Utility.pause(movement.time), "completed")
		#
	#yield($Gui.fade_transition(), "completed")
	#entities_handler.remove_child(player)
	#set_map(new_map)
	#
	#var last_map: GameData.Map = area_data.get(actual_map.map_name)
#
	#if not actual_map.is_cutscene_event(last_map.is_event_occurring, last_map.actual_event):
		#actual_map.load_map(last_map)
		#enter_map_flying(target, new_position)
	#else: 
		#yield(cutscene_handler(actual_map.get_event(last_map.actual_event)), "completed")
		#$Gui.level_up_in_queue = false
#
#func enter_map_flying(target: int, position: Vector2) -> void:
	#player.position = position
	#entities_handler.add_child(player)
	#var platform_target: Platform = entities_handler.get_platform(target)
	#
	#$Gui.show_transition()
	#
	#for movement in platform_target.get_opposite_movements():
		#player.start_fly_change_map(movement.direction)
		#yield(Utility.pause(movement.time), "completed")
	#
	#player.end_fly_change_map()
	#player.direction = Direction.get_opposite_direction(platform_target.direction)
		#
	#yield(Utility.pause(0.1), "completed")
	#entities_handler.enable_player()
#
	#yield(Utility.pause(0.15), "completed")
	#
	#$Gui.enable_menu()
	#$Gui.level_up_in_queue = false
	#Events.emit_signal("start_level_up")
	#
#func enter_world_map() -> void:
	#$Gui.level_up_in_queue = true
	#$Gui.disable_menu()
	#entities_handler.disable_entities()
	#
	#original_sprite_position = player.sprite.position
	#player.play_animation("Enter Map")
	#
	#yield(Utility.pause(0.25), "completed")
	#
	#AudioManager.stop_music()
	#AudioManager.play_music("WorldMap1")
	#player.sprite.z_index = 100
	#yield(Utility.animate(player.sprite, "position",  Vector2(0, 0), Vector2(0, -140), 0.4), "completed")
#
	#$Gui.fade_transition()
	#yield(Utility.animate(player.sprite, "position", Vector2(0, -140), Vector2(0, -350), 0.6), "completed")
	#
	#$Gui.hide()
	#player.disable_smoothing()
	#entities_handler.remove_child(player)
	#actual_map.queue_free()
	#actual_map = null
	#
	#add_child(world_map)
	#AudioManager.play_music(world_map.music_path)
	#world_map.init(game_data.character, area)
	#
	#show_zone()
	#yield($Gui.show_transition(), "completed")
	#$Gui.enable_menu()
	#
#func exit_world_map(new_area: String, new_map: String, position: Vector2) -> void:
	#$Gui.disable_menu()
	#yield($Gui.fade_transition(), "completed")
	#
	#remove_child(world_map)
	#world_map.reset()
	#
	#set_area(new_area)
	#set_map(new_map)
	#
	#var last_map: GameData.Map = area_data.get(actual_map.map_name)
	#
	#if not actual_map.is_cutscene_event(last_map.is_event_occurring, last_map.actual_event):
		#actual_map.load_map(last_map)
		#entities_handler.add_child(player)
		#player.position = position
#
		#$Gui.show()
		#$Gui.show_transition()
		#
		#yield(Utility.animate(player.sprite, "position", Vector2(0, -300), Vector2(0, -165), 0.45), "completed")
		#player.play_animation("Enter Map", true)
		#yield(Utility.animate(player.sprite, "position", Vector2(0, -165), original_sprite_position, 0.55), "completed")
		#
		#player.sprite.z_index = 0
		#player.play_animation("Stand")
		#entities_handler.enable_player()
		#player.enable_smoothing()
		#$Gui.enable_menu()
		#$Gui.level_up_in_queue = false
		#Events.emit_signal("start_level_up")
	#else:
		#cutscene_handler(actual_map.get_event(last_map.actual_event))
	#
#func close_dialogue_box() -> void:
	#match $Gui.dialogue_type:
		#"Interaction": entities_handler.end_npc_dialogue()
		#"Cutscene": actual_map.close_dialogue_box()
	#
	#$Gui.dialogue_type = ""
	#
#func load_character(character: String, first_load: bool = false) -> void:
	#if not first_load:
		#character_data.stats = player.stats
		#FileManager.update_character_file(player.character_name, character_data)
	#
	#character_data = FileManager.load_character_file(character)
	#game_data.character = character
	##actual_map.update_npc(character_data)
	#if not first_load:
		#player.reset()
	#player.load_character(character, character_data)
	#$Gui.load_character(character, character_data.stats, character_data.sprite)
#
#func game_over() -> void:
	#AudioManager.play_music("Death")
	#$Gui.disable_menu()
	#yield(Utility.pause(1.5), "completed")
	#yield($Gui.fade_transition(), "completed")
	#$Gui.move_off_screen()
	#$Gui.hide_boss_bar()
	#entities_handler.remove_child(player)
	#set_area("Other World")
	#set_map("North Kai's Planet")
	#player.position = Vector2(-72, 20)
	#entities_handler.add_child(player)
	#player.sprite.flip_h = false
	#player.sprite.play("Halo")
	#yield(Utility.pause(1.5), "completed")
	#yield($Gui.show_transition(), "completed")
	#Events.emit_signal("open_interface", "GameOver", [])
	#
#func update_maps(areas_data: Dictionary) -> void:
	#var local_area_data: Dictionary
	#for current_area in areas_data.keys():
		#local_area_data = FileManager.load_area_file(current_area) if current_area != area else area_data
		#var new_area_data = areas_data[current_area]
		#for map in new_area_data.keys():
			#local_area_data[map].actual_event = new_area_data[map].actual_event
			#local_area_data[map].is_event_occurring = new_area_data[map].is_event_occurring
		#
		#if current_area != area:
			#FileManager.update_area_file(current_area, local_area_data)
#
#func update_tutorial_data(key: String) -> void:
	#game_data.tutorial[key] = false
		#
#func update_state_item(id: String) -> void:
	#area_data[actual_map.map_name].items[id] = false
#
#func update_state_mission(name_npc: String, state: String) -> void:
	#area_data[actual_map.map_name].npcs[name_npc] = state
	#
#func get_player_stats() -> void:
	#yield(Utility.pause(0), "completed")
	#Events.emit_signal("response_player_stats", player.sprite_name, player.stats)
#
#func unlock_character(name: String) -> void:
	#var local_characters_unlocked_data: Dictionary = FileManager.load_characters_unlocked_file()
	#local_characters_unlocked_data[name] = true
	#FileManager.update_characters_unlocked_file(local_characters_unlocked_data)
	#
#func update_npc_events(areas_data: Dictionary, add: bool = true) -> void:
	#var local_area_data: Dictionary
	#for current_area in areas_data.keys():
		#local_area_data = FileManager.load_area_file(current_area) if current_area != area else area_data
		#var new_area_data = areas_data[current_area]
		#for map in new_area_data.keys():
			#add_event(local_area_data[map], new_area_data[map]) if add else remove_event(local_area_data[map], new_area_data[map])
#
		#if current_area != area:
			#FileManager.update_area_file(current_area, local_area_data)
			#
#func add_event(map_data: GameData.Map, mission_data: GameData.MissionData):
	#for item in mission_data.items:
		#map_data.items[item] = true
	#for npc in mission_data.npcs:
		#map_data.npcs[npc] = "Start"
		#
#func remove_event(map_data: GameData.Map, mission_data: GameData.MissionData):
	#for item in mission_data.items:
		#map_data.items.erase(item)
	#for npc in mission_data.npcs:
		#map_data.npcs.erase(npc)
	#
#func save_game() -> void:
	#game_data.position = player.position
	#game_data.inventory = $Gui.inventory
	#game_data.map = actual_map.map_name
	#game_data.area = area
	#FileManager.update_area_file(game_data.area, area_data)
	#var character_data = GameData.Character.new(true, player.sprite_name)
	#character_data.stats = player.stats
	#FileManager.update_character_file(game_data.character, character_data)
	#world_map.save()
	#FileManager.save_game(game_data)
#
#func back_to_title_screen() -> void:
	#AudioManager.stop_music()
	#get_tree().change_scene(Paths.TITLESCREEN)
#
#func ask_actual_area() -> void:
	#yield(Utility.pause(0), "completed")
	#Events.emit_signal("send_actual_area", area)
