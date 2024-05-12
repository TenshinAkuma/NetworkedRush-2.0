extends Control


func _on_start_game_pressed():
	var select_game = load("res://Scenes/UIScenes/load_game_scene.tscn").instantiate()
	get_node("..").add_child(select_game)
	queue_free()


func _on_exit_pressed():
	get_tree().quit()
