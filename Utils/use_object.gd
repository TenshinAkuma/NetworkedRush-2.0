extends Area2D

@export var object_scene: String
@export var player_action: String
@export var interaction_key: String

var _is_on_area: bool


func _unhandled_input(_event):
	if Input.is_action_just_pressed("interact") and _is_on_area:
		SceneManager.go_to_object_scene(object_scene)

func _on_body_entered(body):
	if body is Player:
		_is_on_area = true
		UIManager.display_interaction(player_action, interaction_key, _is_on_area)


func _on_body_exited(body):
	if body is Player:
		_is_on_area = false
		UIManager.display_interaction(player_action, interaction_key, _is_on_area)
			
