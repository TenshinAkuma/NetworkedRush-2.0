extends Control


signal start_game
signal back_to_menu


func _on_start_game_pressed():
	if %LineEdit.text == "":
		$NinePatchRect/MarginContainer/VBoxContainer/Label.text = "Please Enter your character name!"
	else:
		var player_name: String = %LineEdit.text
		PlayerData.player_name = player_name
		start_game.emit()


func _on_back_menu_pressed():
	back_to_menu.emit()
