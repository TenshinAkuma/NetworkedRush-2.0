extends Control

const TaskPanel = preload("res://Scenes/UIScenes/task_panel.tscn")

var task_id: int = 0

func _ready():
	
	for task in TaskManager._tasks.keys():
		print(TaskManager._completed_task.find(TaskManager._tasks[task]))
		if TaskManager._completed_task.find(TaskManager._tasks[task]) == -1 or TaskManager._active_task.find_key(TaskManager._tasks[task]) == -1:
			var task_panel = TaskPanel.instantiate()
			task_panel.task_title = TaskManager._tasks[task]["name"]
			task_panel.task_description = TaskManager._tasks[task]["description"]
			task_panel.task_id = TaskManager._tasks.find_key(TaskManager._tasks[task])
			get_node("NinePatchRect/MarginContainer/Contents/MarginContainer/ScrollContainer/Tasks").add_child(task_panel)
		else:
			pass


func _on_log_out_pressed():
	queue_free()
