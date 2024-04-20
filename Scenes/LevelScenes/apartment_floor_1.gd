extends Node2D


func _ready():
	
	if SceneManager.target_spawn_tag != "":
		on_spawn(SceneManager.target_spawn_tag)
	
	for device in get_tree().get_nodes_in_group("devices"):
		device.monitoring = false
		device.connect("connect_device", Callable(self, "initiate_connect_mode"))

func on_spawn(spawn_tag: String):
	var spawn_point_path = "Doors/" + spawn_tag
	var spawn_point = get_node(spawn_point_path) as SceneChanger
	
	SceneManager.player_spawn(spawn_point.spawn_point.global_position, spawn_point.spawn_orientation)

func initiate_connect_mode():
	pass
