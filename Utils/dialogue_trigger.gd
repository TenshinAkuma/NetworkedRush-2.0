extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String
@export var player_action: String
@export var interaction_key: String

const Dialogue = preload("res://Dialogue/balloon.tscn")

var _on_area: bool = false

func _unhandled_input(_event):
	if Input.is_action_just_pressed("talk") and _on_area:
		GameManager.start_dialogue(dialogue_resource, dialogue_start)
	
func _on_body_entered(body):
	if body is Player:
		_on_area = true
		UIManager.display_interaction(player_action, interaction_key, _on_area)
	else:
		pass


func _on_body_exited(body):
	if body is Player:
		_on_area = false
		UIManager.display_interaction(player_action, interaction_key, _on_area)
	else:
		pass
