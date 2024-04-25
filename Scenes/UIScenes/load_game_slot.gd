extends NinePatchRect

@export var file_path: String

func _ready():
	if not FileAccess.file_exists(file_path):
		$LoadGameContainer.hide()
		$NewGameContainer.show()
		return
	else:
		var load_game = GameData.new()
		load_game.load_game(file_path)
		
		var load_data = load_game.game_data
		%PlayerName.text = load_data["playerData"]["playerName"]
		%Level.text = "Player Level: " + str( load_data["playerData"]["playerLevel"])
		%Packets.text = str( load_data["playerData"]["packetPoints"]) + " packets"
		%PlayerTitle.text = load_data["playerData"]["currentTitle"]
		var last_task_id = int(load_data["taskData"]["taskID"])
		var last_objective_id = int(load_data["taskData"]["objectiveID"])
		if last_task_id in TaskManager._tasks.keys():
			%LastObjective.text = TaskManager._tasks[last_task_id]["objectives"][last_objective_id]
		else:
			%LastObjective.text = "No Pending Task"


func _on_load_pressed():
	var load_game = GameData.new()
	load_game.load_game(file_path)
	var _game_data = load_game.game_data
	load_game.load_game_data(_game_data)
	GameManager.save_path = file_path
	
	
	get_tree().paused = false
	GameManager.load_game(file_path)
	var current_scene = "MainMenu"
	var target_scene = "player_apartment"
	SceneManager.go_to_map(current_scene, target_scene)


func _on_delete_pressed():
	if FileAccess.file_exists(file_path):
		DirAccess.remove_absolute(file_path)
	if not FileAccess.file_exists(file_path):
		$LoadGameContainer.hide()
		$NewGameContainer.show()
		return


func _on_new_game_pressed():
	var new_game = GameData.new()
	new_game.reset_data()
	GameManager.save_path = file_path
	
	var input_name_scene = load("res://Scenes/UIScenes/input_player_name.tscn").instantiate()
	get_node("../../..").add_child(input_name_scene)
	get_node("../..").queue_free()
