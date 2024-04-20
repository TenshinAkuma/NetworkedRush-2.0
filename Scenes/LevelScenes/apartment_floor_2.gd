extends Node2D

func _ready():
	if SceneManager.target_spawn_tag != "":
		on_spawn(SceneManager.target_spawn_tag)
		
	if not GameManager.on_pointing_object.is_connected(pointing):
		GameManager.on_pointing_object.connect(pointing)

func on_spawn(spawn_tag: String):
	print(spawn_tag)
	var spawn_point_path = "Doors/" + spawn_tag
	var spawn_point = get_node(spawn_point_path) as SceneChanger
	
	SceneManager.player_spawn(spawn_point.spawn_point.global_position, spawn_point.spawn_orientation)
	
func pointing(object: String, is_play: bool):
	
	$TileMap.get_node(object).set_visible(is_play)


func _on_detect_prologue_body_entered(body):
	if body is Player and TaskManager.current_task_id == 0 and TaskManager.current_objective_id == 0:
		GameManager.start_dialogue(load("res://Dialogue/Prologue.dialogue"), "phone_ring")
