extends Control



func _on_new_game_pressed():
	var map_to_load: String = "map_1"
	SceneManager.go_to_map(self.name, map_to_load)


func _on_exit_pressed():
	get_tree().quit()
