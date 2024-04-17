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
		"objectives" : {
			1 : "Take the telephone call from the developer.",
			2 : "Talk to Alex the gamer guy."
		}
	},
	1 : {
		"name" : "The Star Network",
		"currentObjective" : 0,
		"reward" : 300,
		"exp" : 25,
		"objectives" : {
			1 : "Diagnose the problem with Alex.",
			2 : "Establish a single wired connection from the router the the PC.",
			3 : "Create a wired connection between the router and the TV.",
			4 : "Talk to alex to get your reward."
		}
	}
}

func add_task(task_id: int):
	if task_id in _tasks.keys():
		_active_task[task_id] = _tasks[task_id]
		
	if _active_task.has(task_id):
		var task_name = _active_task[task_id]["name"]
		on_display_task_name.emit(task_name)
		update_objective(task_id)
		is_task_active = true

func update_objective(task_id: int):
	_active_task[task_id]["currentObjective"] += 1
	current_objective_id = _active_task[task_id]["currentObjective"]
	if current_objective_id in _active_task[task_id]["objectives"].keys():
		var objective_description: String = _active_task[task_id]["objectives"][current_objective_id]
		on_display_objective.emit(objective_description)
	else:
		task_completed(task_id)
		
func task_completed(task_id: int):
	task_reward(task_id)
	_completed_task.append(_tasks[task_id]["name"])
	_active_task.erase(task_id)
	is_task_active = false
	
	current_task_id += 1
	current_objective_id = 0
	add_task(current_task_id)
	
func task_reward(task_id: int):
	var packet_points = _active_task[task_id]["reward"]
	var exp_points = _active_task[task_id]["exp"]
	
	on_update_rewards.emit(packet_points, exp_points)
