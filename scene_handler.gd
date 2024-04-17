extends Node

const GameScene = preload("res://Scenes/MainScenes/game_scene.tscn")
const MainMenu = preload("res://Scenes/MainScenes/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if not SceneManager.on_load_map.is_connected(load_map):
		SceneManager.on_load_map.connect(load_map)
		
	if not SceneManager.on_back_to_main_menu.is_connected(load_main_menu):
		SceneManager.on_back_to_main_menu.connect(load_main_menu)


func load_map(current_scene, target_map):
	var game_scene = GameScene.instantiate()
	add_child(game_scene)
	game_scene.add_child(target_map)
	get_node(current_scene).queue_free()
	
func load_main_menu():
	get_tree().paused = false
	var main_menu = MainMenu.instantiate()
	main_menu.name = "MainMenu"
	add_child(main_menu)
	get_node("GameScene").queue_free()
	
