extends Node2D

const Dialogue = preload("res://Dialogue/balloon.tscn")

func _ready():
	
	if not SceneManager.on_load_level.is_connected(load_level):
		SceneManager.on_load_level.connect(load_level)
		
	if not GameManager.on_start_dialogue.is_connected(start_dialogue):
		GameManager.on_start_dialogue.connect(start_dialogue)
		

func load_level(current_scene, scene_to_load):
	print(scene_to_load)
	add_child(scene_to_load)
	get_node(current_scene).queue_free()
	
	
func start_dialogue(dialogue_resource, dialogue_start):
	var dialogue = Dialogue.instantiate()
	dialogue.name = "DialogueBox"
	add_child(dialogue)
	dialogue.start(dialogue_resource, dialogue_start)
	



