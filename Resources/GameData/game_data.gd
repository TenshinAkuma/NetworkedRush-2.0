class_name GameData extends Node


var game_data: Dictionary

func save():
	var _game_data = {
			"playerData" : {
				"playerName" : PlayerData.player_name,
				"playerLevel" : PlayerData.player_level,
				"expPoints" : PlayerData.player_exp,
				"expRequired" : PlayerData.required_exp,
				"packetPoints" : PlayerData.packets,
				"playerTitles" : PlayerData.titles,
				"currentTitle" : PlayerData.current_title
			},
			"taskData": {
				"taskID" : TaskManager.current_task_id as int,
				"objectiveID" : TaskManager.current_objective_id as int,
			}
	}
	return _game_data
	
func save_game(save_path: String):
	var _save_game = FileAccess.open(save_path, FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	_save_game.store_line(json_string)
	print("json_string")
	
func load_game(save_path: String):
	if not FileAccess.file_exists(save_path):
		print("No data has been saved")
		return
		
	var _save_game = FileAccess.open(save_path, FileAccess.READ)
	
	while _save_game.get_position() < _save_game.get_length():
		var json_string = _save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		game_data = json.get_data()
		print(game_data)
		
func load_game_data(game_data_to_load: Dictionary):
	PlayerData.player_name = game_data_to_load["playerData"]["playerName"]
	PlayerData.player_level = game_data_to_load["playerData"]["playerLevel"]
	PlayerData.player_exp = game_data_to_load["playerData"]["expPoints"]
	PlayerData.required_exp = game_data_to_load["playerData"]["expRequired"]
	PlayerData.packets = game_data_to_load["playerData"]["packetPoints"]
	PlayerData.titles = game_data_to_load["playerData"]["playerTitles"]
	PlayerData.current_title = game_data_to_load["playerData"]["currentTitle"]
	
	
	TaskManager.current_task_id = game_data["taskData"]["taskID"]
	TaskManager.current_objective_id = game_data["taskData"]["objectiveID"]
	TaskManager.load_objective(game_data["taskData"]["taskID"])
	print(TaskManager._active_task)

func reset_data():
	PlayerData.player_name = ""
	PlayerData.player_level = 0
	PlayerData.player_exp = 0
	PlayerData.required_exp = 30
	PlayerData.packets = 0
	PlayerData.titles.clear()
	PlayerData.current_title = ""
	
	TaskManager.current_task_id = 0
	TaskManager.current_objective_id = 0
	TaskManager._active_task.clear()
	TaskManager._completed_task.clear()
