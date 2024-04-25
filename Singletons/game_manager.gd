extends Node

signal on_start_dialogue(dialogue_resource, dialogue_start)
signal on_pointing_object(object: String, is_play: bool,)
signal on_load_game(save_path: String)
signal on_show_cert(title: String)

var save_path: String

var is_show_pointer: bool
var is_new_game: bool

func start_dialogue(dialogue_resource: DialogueResource, dialogue_start: String):
	on_start_dialogue.emit(dialogue_resource, dialogue_start)

func point_object(object: String, is_play: bool = false):
	on_pointing_object.emit(object, is_play)

func load_game(load_path):
	var game_data = GameData.new()
	game_data.load_game(load_path)
	var _game_data = game_data.game_data
	game_data.load_game_data(_game_data)
		
