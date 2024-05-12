extends Node2D

@onready var tile_map = $TileMap
@onready var connect_device = Connect.new()
@onready var line_preview = $Cables/LinePreview

var astar = AStarGrid2D.new()
var tile_map_layer: int = 2
var device_detection_layer: int = 6
var paint_property: String = "is_solid"
var is_show_line_preview: bool = false
var start_device: Vector2

func _ready():
	
	if SceneManager.target_spawn_tag != "":
		on_spawn(SceneManager.target_spawn_tag)
	
	if !TaskManager._active_task.is_empty() and TaskManager._active_task.has(2):
		for device in get_tree().get_nodes_in_group("devices"):
			device.connect("connect_device", Callable(self, "initiate_connect_mode"))
		
func _process(_delta):
	if !TaskManager._active_task.is_empty() and TaskManager._active_task.has(2):
		if TaskManager._active_task[TaskManager.current_task_id]["currentObjective"] == 3:
			device_detection_layer = 6
			$Devices/PC1.monitoring = true
			$Devices/PC2.monitoring = true
			$Devices/PC3.monitoring = false
		elif TaskManager._active_task[TaskManager.current_task_id]["currentObjective"] == 4:
			device_detection_layer = 7
			$Devices/PC1.monitoring = false
			$Devices/PC2.monitoring = true
			$Devices/PC3.monitoring = true
		elif TaskManager._active_task[TaskManager.current_task_id]["currentObjective"] == 5:
			device_detection_layer = 5
			$Devices/PC1.monitoring = true
			$Devices/PC2.monitoring = false
			$Devices/PC3.monitoring = true
		else:
			$Devices/PC1.monitoring = false
			$Devices/PC2.monitoring = false
			$Devices/PC3.monitoring = false
	else:
		$Devices/PC1.monitoring = false
		$Devices/PC2.monitoring = false
		$Devices/PC3.monitoring = false
			
	if is_show_line_preview:
		var end_position = $Player.global_position
		connect_device.show_line_preview(astar, tile_map, device_detection_layer, line_preview, start_device, end_position)
	else:
		line_preview.clear_points()

func on_spawn(spawn_tag: String):
	var spawn_point_path = "Doors/" + spawn_tag
	var spawn_point = get_node(spawn_point_path) as SceneChanger
	
	SceneManager.player_spawn(spawn_point.spawn_point.global_position, spawn_point.spawn_orientation)

	
func initiate_connect_mode(device_position):
	print("connecting")
	if not connect_device.is_connect_mode:
		start_device = device_position
		connect_device.setup_astar(astar, tile_map, tile_map_layer, paint_property)
		connect_device.is_connect_mode = true
	elif start_device != device_position:
		verify_connection(device_position)
		connect_device.is_connect_mode = false
	else:
		pass
		
	is_show_line_preview = connect_device.is_connect_mode
	
func verify_connection(end_point: Vector2):
		
	var device_cable = Line2D.new()
	device_cable.name = "cable" + str(device_detection_layer)
	device_cable.width = 4
	device_cable.default_color = Color.DODGER_BLUE
	device_cable.z_index = 3
	
	var start_connection = tile_map.local_to_map(start_device)
	var end_connection = tile_map.local_to_map(end_point)
	
	connect_device.create_line(astar, tile_map, start_connection, end_connection, device_cable)
	
	if TaskManager._active_task[TaskManager.current_task_id]["currentObjective"] == 3 and end_point.is_equal_approx($Devices/PC2.get_node("DevicePosition").global_position):
		get_node("Cables").add_child(device_cable)
		TaskManager.update_objective(TaskManager.current_task_id)
	elif TaskManager._active_task[TaskManager.current_task_id]["currentObjective"] == 4 and end_point.is_equal_approx($Devices/PC3.get_node("DevicePosition").global_position):
		get_node("Cables").add_child(device_cable)
		TaskManager.update_objective(TaskManager.current_task_id)
	elif TaskManager._active_task[TaskManager.current_task_id]["currentObjective"] == 5 and end_point.is_equal_approx($Devices/PC1.get_node("DevicePosition").global_position):
		get_node("Cables").add_child(device_cable)
		TaskManager.update_objective(TaskManager.current_task_id)
	else:
		pass
