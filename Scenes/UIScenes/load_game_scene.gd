extends Control


func _on_back_pressed():
	var start_menu = load("res://Scenes/UIScenes/menu.tscn").instantiate()
	get_node("..").add_child(start_menu)
	queue_free()
