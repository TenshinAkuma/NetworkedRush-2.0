class_name GameData extends Node


var game_data: Dictionary
var default_tasks = {
	0 : {
		"name" : "In the Beningging",
		"currentObjective" : 0,
		"reward" : 300,
		"exp" : 25,
		"title" : "Beginner",
		"objectives" : {
			1 : "Answer the telephone and talk to The Developer",
			2 : "Check your computer to view tasks.",
			3 : "Take the task Varjis will give",
		},
	},
	1 : {
		"name" : "The Star Network",
		"currentObjective" : 0,
		"reward" : 100,
		"exp" : 25,
		"title" : "Star Wizard",
		"objectives" : {
			1 : "Diagnose the problem with Alex.",
			2 : "Establish a single wired connection from the router the the PC.",
			3 : "Create a wired connection between the router and the TV.",
			4 : "Talk to alex to get your reward.",
		},
	},
	2 : {
		"name" : "The Lord of the Rings",
		"currentObjective" : 0,
		"reward" : 200,
		"exp" : 50,
		"title" : "Lord of the Rings",
		"objectives" : {
			1 : "Ask Varjis, your AI assistant, if there's another task",
			2 : "Consult with Ms. Pierre about her request",
			3 : "Connect PC 1 to PC 2",
			4 : "Connect PC 2 to PC 3",
			5 : "Connect PC 3 to PC 1",
			6 : "Talk to Ms. Pierre to get rewards"
		},
	}
}

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
		game_data.merge(json.get_data())
		
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
	TaskManager._tasks.merge(default_tasks, true)
