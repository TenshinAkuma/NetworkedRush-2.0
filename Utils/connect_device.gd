class_name ConnectDevice
extends Area2D

signal connect_device(device_position: Vector2)

@export var player_action: String
@export var interaction_key: String

var _on_area: bool = false

func _unhandled_input(_event):
	if Input.is_action_just_pressed("interact") and _on_area:
		var device_position: Vector2 = $DevicePosition.global_position
		connect_device.emit(device_position)

func _on_body_entered_device(body):
	if body is Player:
		_on_area = true
		UIManager.display_interaction(player_action, interaction_key, _on_area)
	else:
		pass

func _on_body_exited_device(body):
	if body is Player:
		_on_area = false
		UIManager.display_interaction(player_action, interaction_key, _on_area)
	else:
		pass
