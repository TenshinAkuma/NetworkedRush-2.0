extends Control


func _on_start_game_pressed():
	if %LineEdit.text == "":
		$NinePatchRect/MarginContainer/VBoxContainer/Label.text = "Please Enter your character name!"
	else:
		var start_game = GameData.new()
		await start_game.reset_data()
		
		var player_name: String = %LineEdit.text
		PlayerData.player_name = player_name
		var current_scene = "MainMenu"
		var target_scene = "player_apartment"
		
		SceneManager.go_to_map(current_scene, target_scene)
		await start_game.save_game(GameManager.save_path)


func _on_back_menu_pressed():
	var select_game = load("res://Scenes/UIScenes/load_game_scene.tscn").instantiate()
	get_node("..").add_child(select_game)
	
	queue_free()
