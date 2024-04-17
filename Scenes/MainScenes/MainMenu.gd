extends Control

const Menu = preload("res://Scenes/UIScenes/menu.tscn")
const InputCharName = preload("res://Scenes/UIScenes/input_player_name.tscn")


func _ready():
	init_menu()
	$AnimationPlayer.play
	
func init_menu():
	var menu = Menu.instantiate()
	menu.name = "Menu"
	get_node("CanvasLayer/ColorRect").add_child(menu)
	
	if not menu.new_game_pressed.is_connected(on_new_game):
		menu.new_game_pressed.connect(on_new_game)
	
	if not menu.exit_pressed.is_connected(on_exit):
		menu.exit_pressed.connect(on_exit)
		
	if not menu.load_game.is_connected(on_load_game):
		menu.load_game.connect(on_load_game)

func init_name_input():
	var input_name = InputCharName.instantiate()
	input_name.name = "CharNameInput"
	get_node("CanvasLayer/ColorRect").add_child(input_name)
	
	if not input_name.start_game.is_connected(on_start_game):
		input_name.start_game.connect(on_start_game)
		
	if not input_name.back_to_menu.is_connected(on_back_to_menu):
		input_name.back_to_menu.connect(on_back_to_menu)
		
func on_new_game():
	init_name_input()
		
	get_node("CanvasLayer/ColorRect/Menu").queue_free()
		
func on_back_to_menu():
	init_menu()
	
	get_node("CanvasLayer/ColorRect/CharNameInput").queue_free()
	
	
func on_start_game():
	var current_scene = "MainMenu"
	var target_scene = "player_apartment"
	SceneManager.go_to_map(current_scene, target_scene)

func on_load_game():
	var game_data = GameData.new()
	game_data.load_game()
	var current_scene = "MainMenu"
	var target_scene = "player_apartment"
	SceneManager.go_to_map(current_scene, target_scene)
	
func on_exit():
	get_tree().quit()
