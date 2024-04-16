class_name SceneChanger
extends Area2D

@export var target_scene: String
@export var spawn_tag: String
@export var spawn_orientation: Vector2
@export var player_action: String
@export var interaction_key: String

@onready var spawn_point = $spawn_point

var _on_area: bool = false


func _unhandled_input(_event):
	if Input.is_action_just_pressed("interact") and _on_area:
		var current_scene = str(get_node("../..").name)
		SceneManager.go_to_level(current_scene, target_scene, spawn_tag)


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
