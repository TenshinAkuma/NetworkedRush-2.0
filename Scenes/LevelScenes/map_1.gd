class_name Map1
extends Node2D


func _ready():
	
	if SceneManager.target_spawn_tag:
		on_spawn(SceneManager.target_spawn_tag)

func on_spawn(spawn_tag: String):
	var spawn_point_path = "Doors/" + spawn_tag
	var spawn_point = get_node(spawn_point_path) as SceneChanger
	
	SceneManager.player_spawn(spawn_point.spawn_point.global_position, spawn_point.spawn_orientation)
