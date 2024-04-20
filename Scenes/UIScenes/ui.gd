extends CanvasLayer

const Dialogue = preload("res://Dialogue/balloon.tscn")

var is_paused: bool
# Called when the node enters the scene tree for the first time.
func _ready():
	
	%Name.text = PlayerData.player_name
	%Level.text = "Lvl." + str(PlayerData.player_level)
	%Packet.text = str(PlayerData.packets)
	
	%TaskNotif.hide()
	%HelpPanel.hide()
	%Hint.visible = false
	%Settings.hide()
			
	if not GameManager.on_start_dialogue.is_connected(start_dialogue):
		GameManager.on_start_dialogue.connect(start_dialogue)
		
	if not UIManager.on_update_task.is_connected(display_objective):
		UIManager.on_update_task.connect(display_objective)
		
	if not UIManager.on_update_rewards.is_connected(update_rewards):
		UIManager.on_update_rewards.connect(update_rewards)
		
	if not UIManager.on_display_interaction.is_connected(display_interaction):
		UIManager.on_display_interaction.connect(display_interaction)
		
	if not PlayerData.on_update_player_level.is_connected(update_player_level):
		PlayerData.on_update_player_level.connect(update_player_level)
		
	if not GameManager.on_show_cert.is_connected(show_cert):
		GameManager.on_show_cert.connect(show_cert)
		
	if not SceneManager.on_load_object_scene.is_connected(load_object_scene):
		SceneManager.on_load_object_scene.connect(load_object_scene)


func load_object_scene(object_scene_path):
	get_node("HUD").add_child(object_scene_path)

func show_cert():
	var cert = load("res://Scenes/UIScenes/certificate.tscn").instantiate()
	cert.name = "Certificate"
	add_child(cert)
	
func start_dialogue(dialogue_resource, dialogue_start):
	var dialogue = Dialogue.instantiate()
	dialogue.name = "DialogueBox"
	add_child(dialogue)
	dialogue.start(dialogue_resource, dialogue_start)
	
func update_player_level(new_level):
	%Level.text = "Lvl." + str(new_level)
	
	
func display_objective(_task_name: String, objective_description: String):
	%Objective.text = "<" + objective_description + ">"
	$ObjectiveTimer.start()
	%TaskNotif.show()
	
func _on_objective_timer_timeout():
	%TaskNotif.hide()


func display_interaction(interaction_hint, is_hint_visible):
	%Hint.visible = is_hint_visible
	%Hint.text = interaction_hint

	
func update_rewards(_packet_points, _exp_points):
	%Packet.text = str(PlayerData.packets)


func _on_settings_btn_pressed():
	is_paused = !get_tree().paused
	get_tree().paused = is_paused
	%Settings.show()


func _on_help_btn_pressed():
	is_paused = !get_tree().paused
	get_tree().paused = is_paused
	%HelpPanel.show()
