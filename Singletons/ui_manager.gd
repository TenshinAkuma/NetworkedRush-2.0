extends Node

signal on_display_interaction(interaction: String, key: String)
signal on_start_dialogue(dialogue_resource: DialogueResource, dialogue_start: String)
signal on_dialogue_pause(dialogue_paused: bool)

var is_on_dialogue: bool

func display_interaction(interaction: String, key: String, is_visible: bool):
	var interaction_hint = "Press [" + key + "] to " + interaction
	on_display_interaction.emit(interaction_hint, is_visible)

func start_dialogue(dialogue_resource: DialogueResource, dialogue_start: String):
	on_start_dialogue.emit(dialogue_resource, dialogue_start)
