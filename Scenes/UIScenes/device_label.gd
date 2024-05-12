extends Control

@export var device_name: String


func _ready():
	$DeviceName.text = device_name
	$DeviceName.hide()


func _on_label_detect_body_entered(body):
	if body is Player:
		$DeviceName.show()
		$AnimationPlayer.play("show_label")


func _on_label_detect_body_exited(body):
	if body is Player:
		$DeviceName.hide()
