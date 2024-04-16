extends Node

signal on_update_player_level(player_level)

var player_name: String = "<Playername>"
var player_level: int = 0
var packets: int
var player_exp: int
var required_exp: int = 30

func update_reward(packet_points: int, exp_points: int):
	packets += packet_points
	player_exp += exp_points
	
	if player_exp >= required_exp:
		player_level += 1
		player_exp = 0
		required_exp = round(required_exp*1.5)
		
		on_update_player_level.emit(player_level)
	else:
		pass
