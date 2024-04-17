extends Node2D

@onready var tile_map = $TileMap
@onready var connect_device = $Connect
@onready var line_preview = $Cables/LinePreview


var astar = AStarGrid2D.new()
var tile_map_layer: int = 2
var device_detection_layer: int
var paint_property: String = "is_solid"
var is_show_line_preview: bool = false
var start_device: Vector2

func _ready():
	if SceneManager.target_spawn_tag:
		on_spawn(SceneManager.target_spawn_tag)

		
	for device in get_tree().get_nodes_in_group("devices"):
		device.monitoring = false
		device.connect("connect_device", Callable(self, "initiate_connect_mode"))
				
func _process(_delta):
	if TaskManager.current_task_id == 1:
		if TaskManager.current_objective_id == 2:
			$Devices/Router.monitoring = true
			$Devices/PC.monitoring = true
			device_detection_layer = 5
		elif TaskManager.current_objective_id == 3:
			$Devices/TV.monitoring = true
			$Devices/Router.monitoring = true
			device_detection_layer = 6
		else:
			$Devices/Router.monitoring = false
			$Devices/TV.monitoring = false
			
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
	
	if not connect_device.is_connect_mode:
		start_device = device_position
		connect_device.setup_astar(astar, tile_map, tile_map_layer, paint_property)
		connect_device.is_connect_mode = true
	else:
		verify_connection(device_position)
		connect_device.is_connect_mode = false
		
	is_show_line_preview = connect_device.is_connect_mode

func verify_connection(end_point: Vector2):
		
	var device_cable = Line2D.new()
	device_cable.name = "cable" + str(TaskManager.current_objective_id)
	device_cable.width = 4
	device_cable.default_color = Color.DODGER_BLUE
	
	var start_connection = tile_map.local_to_map(start_device)
	var end_connection = tile_map.local_to_map(end_point)
	
	connect_device.create_line(astar, tile_map, start_connection, end_connection, device_cable)
	
	if TaskManager.current_task_id == 1 and start_device != end_point:
		if TaskManager.current_objective_id == 2 and end_point == $Devices/PC.get_node("DevicePosition").global_position:
			get_node("Cables").add_child(device_cable)
			TaskManager.update_objective(TaskManager.current_task_id)
			
		if TaskManager.current_objective_id == 3 and end_point == $Devices/TV.get_node("DevicePosition").global_position:
			get_node("Cables").add_child(device_cable)
			TaskManager.update_objective(TaskManager.current_task_id)
