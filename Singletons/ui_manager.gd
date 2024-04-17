extends Node

signal on_display_interaction(interaction: String, key: String)

var is_on_dialogue: bool

func display_interaction(interaction: String, key: String, is_visible: bool):
	var interaction_hint = "Press [" + key + "] to " + interaction
	on_display_interaction.emit(interaction_hint, is_visible)

