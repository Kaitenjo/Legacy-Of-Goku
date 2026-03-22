extends Node

signal update_ux(val)
signal stop_use_energy
signal add_entity_attack(entity)
signal update_health(val)
signal update_energy(val)
signal update_defense(val)
signal send_experience_to_player(experience)
signal update_experience(experience)
signal hit(attack, entity)
signal level_up_animation
signal start_level_up
signal check_open_level_up(val)
signal open_interface(type, data)
signal check_collision(vector)
signal checked_collision(position)
signal is_colliding
signal death
signal enable_player
signal stop_continuous_attack
signal player_enter(entity)
signal player_leave(entity)
signal player_change_direction

signal ask_is_world_map_actual_map
signal response_is_world_map_actual_map(val)

signal get_item
signal show_item(icon_item)
signal update_state_item(id_item)

signal open_npc_dialogue
signal check_items_required(items)
signal update_state_mission(name_npc, state)

signal show_explosion(position)
signal enemy_defeated(enemy)

signal entity_in_scouter_range(entity)
signal entity_out_scouter_range(entity)
signal add_drop(drop, position)
signal enter_world_map
signal get_entities_in_scouter_range
signal send_entities_in_scouter_range(enemies)
signal show_entities_sprite
signal platform_change_map(map, target, movements, position_spawn)

signal ask_boss_health
signal response_boss_health(val)
signal boss_defeated
signal update_experience_completed
signal initialize_boss_bar(boss_health, boss_name)
signal update_boss_bar_health(val)
signal hide_boss_bar
signal start_cutscene_post_event

signal music_value_changed(val)
signal sfx_value_changed(val)
signal text_speed_value_changed(val)
signal zoom_camera_value_changed(val)
signal update_zoom_camera

signal change_map(map, position, direction, new_direction, payload)
signal remove_player
signal update_maps(new_data)
signal update_npc_events(new_data, add)
signal show_zone

signal update_world_map(index, val)
signal set_goals(list)
signal reset_goals(list)
signal unlock_character(name)
signal load_state_item
signal load_state_npc_mission
signal show
signal fade
signal fade_completed
signal show_completed
signal disable_gui
signal change_scouter_interface(type, data)

signal exit_world_map(name_area, area, position)
signal name_area_world_map(name_area)

signal grab_energy_drop(percentage)
signal grab_health_drop(percentage)

signal load_character(character)
signal reset_dialogues
signal close_interface
signal close_full_screen_interface
signal ask_player_stats
signal response_player_stats(sprite, stats)
signal back_to_title_screen
signal disable_actual_entity
signal enable_actual_entity
signal disable_entities
signal enable_entities 
signal disable_world_map
signal enable_world_map
signal closed_new_item_dialogue_box
signal save_game
signal show_damage_label(damage, position)
signal check_collision_final_flash(ability_position, hit_box_size, attack_direction)
signal send_collision_final_flash(position)

signal close_dialogue_box(type)
signal close_name_zone

signal item_used(item)
signal disable_input_menu
signal enable_input_menu
signal update_inventory(inventory)
signal select_item(item)
signal close_checkpoint
signal update_tutorial_data(val)

signal ask_actual_area
signal send_actual_area(area_name)
