class_name Connect
extends Node

var is_connect_mode: bool = false
var is_connection_valid: bool = false
var target_device: Vector2

func setup_astar(astar: AStarGrid2D, tile_map: TileMap, tile_map_layer: int, paint_property: String):
	
	astar.region = tile_map.get_used_rect()
	print(astar.region)
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	
	for cell in tile_map.get_used_cells(tile_map_layer):
		astar.set_point_solid(cell, is_spot_solid(tile_map, cell, tile_map_layer, paint_property))
		


func is_spot_solid(tile_map: TileMap, spot_to_check: Vector2i, tile_map_layer: int, paint_property: String) -> bool:
	return tile_map.get_cell_tile_data(tile_map_layer, spot_to_check).get_custom_data(paint_property)



func create_line(astar: AStarGrid2D,  tile_map: TileMap, start: Vector2i, end: Vector2i, line: Line2D):
	line.clear_points()
	if start == end or !astar.is_in_boundsv(start) or !astar.is_in_boundsv(end):
		return
		
	var line_path = astar.get_id_path(start, end)

	for cell in line_path:
		## convert the grid coords to gobal position
		var point = tile_map.map_to_local(cell as Vector2)
		line.add_point(point)


func show_line_preview(astar: AStarGrid2D, tile_map: TileMap,  device_detection_layer: int, line_preview: Line2D, start_point: Vector2, end_point: Vector2):
	var end_position = tile_map.local_to_map(end_point)
	var start_position = tile_map.local_to_map(start_point)
	
	if tile_map.get_cell_source_id(device_detection_layer,Vector2i(end_position)) == -1:
		line_preview.set_default_color(Color.RED)
		is_connection_valid = false
	else:
		line_preview.set_default_color(Color.GREEN)
		is_connection_valid = true
		
	create_line(astar, tile_map, start_position, end_position, line_preview)
