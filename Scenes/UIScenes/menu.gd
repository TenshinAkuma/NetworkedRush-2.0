extends Control

signal new_game_pressed
signal exit_pressed
signal load_game

var load_path = "user://save_game.save"


func _ready():
	if not FileAccess.file_exists(load_path):
		%LoadGame.hide()
	else:
		%LoadGame.show()
		
func _on_new_game_pressed():
	new_game_pressed.emit()


func _on_exit_pressed():
	exit_pressed.emit()


func _on_load_game_pressed():
	load_game.emit()
