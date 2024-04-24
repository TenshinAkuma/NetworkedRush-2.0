extends Node2D

func _ready():
	
	if not SceneManager.on_load_level.is_connected(load_level):
		SceneManager.on_load_level.connect(load_level)

		
func load_level(current_scene, scene_to_load):
	add_child(scene_to_load)
	get_node(current_scene).queue_free()

