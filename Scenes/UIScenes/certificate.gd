extends Control

@export var title: String

func _ready():
	$ColorRect/MG/VB/Title.text = title
	
func _on_timer_timeout():
	get_node(".").queue_free()
