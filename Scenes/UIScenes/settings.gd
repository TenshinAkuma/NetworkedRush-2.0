extends Control

var save_path = "user://game_data.save"

func _ready():

	if not TaskManager.on_display_task_name.is_connected(display_task):
		TaskManager.on_display_task_name.connect(display_task)
	
	if not TaskManager.on_display_objective.is_connected(display_objective):
		TaskManager.on_display_objective.connect(display_objective)
		
	display_current_objective()

func display_task(task_name: String):
	%Task.text = task_name
	
func display_objective(objective_description: String):
	%Objective.text = objective_description

func display_current_objective():
	if TaskManager.is_task_active:
		var task_id = TaskManager.current_task_id
		var objective_id = TaskManager.current_objective_id
		if objective_id in TaskManager._active_task[task_id]["objectives"].keys():
			%Objective.text = str(TaskManager._active_task[task_id]["objectives"][objective_id])
	else:
		%Task.text = "No current task"
		%Objective.text = "No current objective"


func _on_save_pressed():
	var game_data = GameData.new()
	game_data.save_game()


func _on_exit_pressed():
	SceneManager.back_to_main_menu()
