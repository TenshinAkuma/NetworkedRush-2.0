extends Node

signal on_display_interaction(interaction: String, key: String)


func display_interaction(interaction: String, key: String, is_visible: bool):
	var interaction_hint = "Press [" + key + "] to " + interaction
	on_display_interaction.emit(interaction_hint, is_visible)
