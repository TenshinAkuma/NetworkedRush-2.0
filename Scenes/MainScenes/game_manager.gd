class_name GameManager
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if not SceneManager.on_load_level.is_connected(load_level):
		SceneManager.on_load_level.connect(load_level)
		
	if TaskManager.current_task_id == 0 and TaskManager.current_objective_id == 0:
		$Timer.start()
		

func _on_timer_timeout():
	UIManager.start_dialogue(load("res://Dialogue/Prologue.dialogue"), "phone_ring")
	
		
func _process(_delta):
		
	if SceneManager.is_game_paused:
		get_tree().paused = SceneManager.is_game_paused
	else:
		get_tree().paused = SceneManager.is_game_paused
		
		
func load_level(current_scene, scene_to_load):
	print(scene_to_load)
	add_child(scene_to_load)
	get_node(current_scene).queue_free()


