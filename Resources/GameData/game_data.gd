class_name GameData
extends Node

func save():
	var _game_data = {
		"playerName" : PlayerData.player_name,
		"playerLevel" : PlayerData.player_level,
		"expPoints" : PlayerData.player_exp,
		"expRequired" : PlayerData.required_exp,
		"packetPoints" : PlayerData.packets,
		"taskID" : TaskManager.current_task_id,
		"objectiveID" : TaskManager.current_objective_id
	}
	return _game_data
	
func save_game():
	var save_game = FileAccess.open("user://save_game.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)
	print("json_string")
	
func load_game():
	if not FileAccess.file_exists("user://save_game.save"):
		return
		
	var save_game = FileAccess.open("user://save_game.save", FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_String = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_String)
		var game_data = json.get_data()
		
