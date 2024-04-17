extends Node

signal on_player_spawn(spawn_point: Vector2, spaw_orientation: String)
signal on_load_level(current_scene, scene_to_load)
signal on_load_map(current_scene: String, map_to_load: String)
signal on_back_to_main_menu


var is_game_paused: bool

var target_spawn_tag: String

func go_to_level(current_scene: String, target_scene: String, spawn_tag: String):
	var scene_to_load
	
	match target_scene:
		"alex_house":
			scene_to_load = load("res://Scenes/LevelScenes/alex_house.tscn").instantiate()
		"map_1":
			scene_to_load = load("res://Scenes/LevelScenes/map_1.tscn").instantiate()
		"apartment_floor_1":
			scene_to_load = load("res://Scenes/LevelScenes/apartment_floor_1.tscn").instantiate()
		"apartment_floor_2":
			scene_to_load = load("res://Scenes/LevelScenes/apartment_floor_2.tscn").instantiate()
			
	if scene_to_load != null:
		target_spawn_tag = spawn_tag
		on_load_level.emit(current_scene, scene_to_load)

func go_to_map(current_scene: String, target_map: String):
	var map_to_load
	
	match target_map:
		"player_apartment":
			map_to_load = load("res://Scenes/LevelScenes/apartment_floor_2.tscn").instantiate()
			
	if map_to_load != null:
		on_load_map.emit(current_scene, map_to_load)
		
func back_to_main_menu():
	on_back_to_main_menu.emit()
		
func player_spawn(spawn_point: Vector2, spawn_orientation: Vector2):
	on_player_spawn.emit(spawn_point, spawn_orientation)
		
