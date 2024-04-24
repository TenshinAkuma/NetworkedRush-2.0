extends Node

signal on_display_objective(objective_description: String)
signal on_display_task_name(task_name: String)
signal on_update_rewards(packet_points: int, exp_points: int)

var _completed_task: Dictionary = {}
var _active_task: Dictionary = {}

var current_task_id: int = 2
var current_objective_id: int = 0

var _tasks: Dictionary = {
	0 : {
		"name" : "In the Beningging",
		"currentObjective" : 0,
		"reward" : 300,
		"exp" : 25,
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
		"description" : "",
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

func add_task(task_id: int):
	if task_id in _tasks.keys():
		_active_task[task_id] = _tasks[task_id]
		
	if _active_task.has(task_id):
		var task_name = _active_task[task_id]["name"]
		update_objective(task_id)
		UIManager.update_task(task_name, _active_task[task_id]["objectives"][current_objective_id])

func update_objective(task_id: int):
	_active_task[task_id]["currentObjective"] += 1
	current_objective_id = _active_task[task_id]["currentObjective"]
	if current_objective_id in _active_task[task_id]["objectives"].keys():
		var objective_description: String = _active_task[task_id]["objectives"][current_objective_id]
		UIManager.update_task(_active_task[task_id]["name"], objective_description)
	else:
		task_completed(task_id)
		
func task_completed(task_id: int):
	task_reward(task_id)
	if TaskManager._active_task[task_id].has("title"):
		GameManager.on_show_cert.emit(TaskManager._active_task[task_id]["title"])
	_completed_task.merge(_tasks[task_id], true)
	_active_task.erase(task_id)
	
	current_task_id += 1
	add_task(current_task_id)
	
func task_reward(task_id: int):
	var packet_points = _active_task[task_id]["reward"]
	var exp_points = _active_task[task_id]["exp"]
	
	PlayerData.update_reward(packet_points, exp_points)
	UIManager.update_rewards(packet_points, exp_points)
	
	
func load_objective(task_id: int):
	_active_task.clear()
	if task_id in _tasks.keys():
		_active_task[task_id] = _tasks[task_id]
		
	if _active_task.has(task_id):
		_active_task[task_id]["currentObjective"] = current_objective_id
