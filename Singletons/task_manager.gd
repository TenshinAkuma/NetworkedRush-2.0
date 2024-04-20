extends Node

signal on_display_objective(objective_description: String)
signal on_display_task_name(task_name: String)
signal on_update_rewards(packet_points: int, exp_points: int)

var _completed_task: Array = []
var _active_task: Dictionary = {}

var current_task_id: int = 0
var current_objective_id: int = 0

var is_task_active: bool = false

var _tasks: Dictionary = {
	0 : {
		"name" : "In the Beningging",
		"currentObjective" : 0,
		"reward" : 300,
		"exp" : 25,
		"description" : "",
		"objectives" : {
			1 : "Take the telephone call from the developer.",
			2 : "Check your computer to view tasks."
		}
	},
	1 : {
		"name" : "The Star Network",
		"currentObjective" : 0,
		"reward" : 100,
		"exp" : 25,
		"title" : "Star Wizard",
		"description" : "Alex wants to set up a wired network connection for his new PC to optimize internet speed and reduce lag during online gaming sessions. He also wants to connect his TV to the network.",
		"objectives" : {
			1 : "Diagnose the problem with Alex.",
			2 : "Establish a single wired connection from the router the the PC.",
			3 : "Create a wired connection between the router and the TV.",
			4 : "Talk to alex to get your reward."
		}
	},
	2 : {
		"name" : "The Lord of the Rings",
		"currentObjective" : 0,
		"reward" : 200,
		"exp" : 30,
		"title" : "Lord of the Rings",
		"description" : "",
		"objectives" : {
			1: "Consult with Ms."
		}
	}
}

func add_task(task_id: int):
	if task_id in _tasks.keys():
		_active_task[task_id] = _tasks[task_id]
		current_task_id = task_id
		
	if _active_task.has(task_id):
		var task_name = _active_task[task_id]["name"]
		update_objective(task_id)
		UIManager.update_task(task_name, _active_task[task_id]["objectives"][current_objective_id])
		is_task_active = true

func update_objective(task_id: int):
	_active_task[task_id]["currentObjective"] += 1
	current_objective_id = _active_task[task_id]["currentObjective"]
	if current_objective_id in _active_task[task_id]["objectives"].keys():
		var objective_description: String = _active_task[task_id]["objectives"][current_objective_id]
		UIManager.update_task(_active_task[task_id]["name"], objective_description)
	else:
		task_completed(task_id)
		current_objective_id = 0
		
func task_completed(task_id: int):
	task_reward(task_id)
	_completed_task.append(_tasks[task_id])
	print(_completed_task)
	_active_task.erase(task_id)
	
	if _active_task.is_empty():
		is_task_active = false
	
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
