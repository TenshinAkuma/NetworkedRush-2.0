extends Control


func _on_timer_timeout():
	get_node(".").queue_free()