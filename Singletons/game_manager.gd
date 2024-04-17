extends Node

signal on_start_dialogue(dialogue_resource, dialogue_start)
signal on_pointing_object(object: String, is_play: bool,)
signal on_load_game

var is_on_dialogue: bool = false

func start_dialogue(dialogue_resource: DialogueResource, dialogue_start: String):
	on_start_dialogue.emit(dialogue_resource, dialogue_start)

func point_object(object: String, is_play: bool = false):
	on_pointing_object.emit(object, is_play)

func load_game():
	var game_data = GameData.new()
	game_data.load_game()
