extends Node

signal on_display_interaction(interaction: String, key: String)
signal on_show_topology_hint(topology, is_visible)
signal on_update_task(task_name: String, objective_description: String)
signal on_update_rewards(packet_points: int, exp_point: int)

func display_interaction(interaction: String, key: String, is_visible: bool):
	var interaction_hint = "Press [" + key + "] to " + interaction
	on_display_interaction.emit(interaction_hint, is_visible)

func update_task(task_name: String, objective_description: String):
	on_update_task.emit(task_name, objective_description)
	
func show_topology_hint(topology: String, is_visible: bool):
	on_show_topology_hint.emit(topology, is_visible)

func update_rewards(paket_points: int, exp_points):
	on_update_rewards.emit(paket_points, exp_points)
