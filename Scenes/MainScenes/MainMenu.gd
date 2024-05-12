extends Control

const Menu = preload("res://Scenes/UIScenes/menu.tscn")
const InputCharName = preload("res://Scenes/UIScenes/input_player_name.tscn")


func _ready():
	init_menu()
	
func init_menu():
	var menu = Menu.instantiate()
	menu.name = "Menu"
	get_node("CanvasLayer/ColorRect").add_child(menu)
