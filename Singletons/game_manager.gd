extends Node

signal on_start_dialogue(dialogue_resource, dialogue_start)


func start_dialogue(dialogue_resource: DialogueResource, dialogue_start: String):
	on_start_dialogue.emit(dialogue_resource, dialogue_start)
