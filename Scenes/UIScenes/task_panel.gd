extends NinePatchRect

@export var task_title: String
@export var task_description: String
@export var task_id: int

func _ready():
	%Title.text = task_title
	%Desciption.text = task_description

func _on_accept_pressed():
	TaskManager.add_task(task_id)
	queue_free()
