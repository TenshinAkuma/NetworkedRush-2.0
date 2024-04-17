class_name GameData extends Node


var save_path: String = "user://save_game.save"


func save():
	var _game_data = {
			"playerData" : {
				"playerName" : PlayerData.player_name,
				"playerLevel" : PlayerData.player_level,
				"expPoints" : PlayerData.player_exp,
				"expRequired" : PlayerData.required_exp,
				"packetPoints" : PlayerData.packets,
			},
			"taskData": {
				"taskID" : TaskManager.current_task_id,
				"objectiveID" : TaskManager.current_objective_id
			}
	}
	return _game_data
	
func save_game():
	var _save_game = FileAccess.open(save_path, FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	_save_game.store_line(json_string)
	print("json_string")
	
func load_game():
	if not FileAccess.file_exists(save_path):
		print("No data has been saved")
		return
		
	var save_game = FileAccess.open(save_path, FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var game_data = json.get_data()
		
		PlayerData.player_name = game_data["playerData"]["playerName"]
		PlayerData.player_level = game_data["playerData"]["playerLevel"]
		PlayerData.player_exp = game_data["playerData"]["expPoints"]
		PlayerData.required_exp = game_data["playerData"]["expRequired"]
		PlayerData.packets = game_data["playerData"]["packetPoints"]
		TaskManager.current_task_id = game_data["taskData"]["taskID"]
		TaskManager.current_task_id = game_data["taskData"]["objectiveID"]
