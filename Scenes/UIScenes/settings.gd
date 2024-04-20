extends Control

var save_path = "user://game_data.save"

func _ready():
	
	if not TaskManager._active_task.is_empty():
		
		var task_id = TaskManager.current_task_id
		var objective_id = TaskManager.current_objective_id
		var task
		var objective
		if objective_id in TaskManager._active_task[task_id]["objectives"].keys():
			task = TaskManager._active_task[TaskManager.current_task_id]["name"]
			objective = TaskManager._active_task[TaskManager.current_task_id]["objectives"][TaskManager.current_objective_id]
		else:
			task = "No Active Task"
			objective = "No current objective"
		%Task.text = task
		%Objective.text = objective
	
	if not UIManager.on_update_task.is_connected(update_task):
		UIManager.on_update_task.connect(update_task)
	
func update_task(task_name, objective_description):
	
	%Task.text = task_name
	%Objective.text = objective_description


func _on_save_pressed():
	var game_data = GameData.new()
	game_data.save_game()
	


func _on_exit_pressed():
	SceneManager.back_to_main_menu()
	hide()


func _on_continue_pressed():
	if not get_tree().paused:
		get_tree().paused = !get_tree().paused
	else:
		get_tree().paused = !get_tree().paused
	hide()


func _on_exit_settings_pressed():
	if not get_tree().paused:
		get_tree().paused = !get_tree().paused
	else:
		get_tree().paused = !get_tree().paused
	hide()
