extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if not UIManager.on_show_topology_hint.is_connected(show_help):
		UIManager.on_show_topology_hint.connect(show_help)
		
	%HelpTitle.text = "NETWORKED RUSH"
	%Info.text = "NETWORKED RUSH is a 2D top-down RPG that immerses players in the role of a Network Engineer. With the goal of introducing fundamental network engineering concepts, the game seeks to inspire interest in pursuing a career in Network Engineering, all while delivering an engaging and entertaining gameplay experience"
	%Image.texture = null


func show_help(image: String, is_help_visible: bool):
	
	match image:
		"star":
			%HelpTitle.text = "Star Network"
			%Image.texture = load("res://Assets/UI/Arts/images.png")
			%Info.text = "A star topology, sometimes known as a star network, is a network topology in which each device is connected to a central hub. It is one of the most prevalent computer network configurations, and it's by far the most popular Network Topology. In this network arrangement, all devices linked to a central network device are displayed as a star."
			
	if is_help_visible:
		show()
	else:
		hide()


func _on_back_pressed():
	if not get_tree().paused:
		get_tree().paused = !get_tree().paused
	else:
		get_tree().paused = !get_tree().paused
	hide()
