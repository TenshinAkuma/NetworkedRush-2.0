extends CanvasLayer

const Dialogue = preload("res://Dialogue/balloon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	%Name.text = PlayerData.player_name
	%Level.text = "Lvl." + str(PlayerData.player_level)
	%Packet.text = str(PlayerData.packets)
	
	%TaskNotif.hide()
	%HelpPanel.hide()
	%Hint.visible = false
	%Settings.hide()
	
	if not UIManager.on_display_interaction.is_connected(display_interaction):
		UIManager.on_display_interaction.connect(display_interaction)
		
	if not UIManager.on_start_dialogue.is_connected(start_dialogue):
		UIManager.on_start_dialogue.connect(start_dialogue)
		
	if not TaskManager.on_display_objective.is_connected(display_objective):
		TaskManager.on_display_objective.connect(display_objective)
		
	if not TaskManager.on_update_rewards.is_connected(update_rewards):
		TaskManager.on_update_rewards.connect(update_rewards)
		
	if not PlayerData.on_update_player_level.is_connected(update_player_level):
		PlayerData.on_update_player_level.connect(update_player_level)

func _process(_delta):
	if UIManager.is_on_dialogue:
		get_tree().paused = UIManager.is_on_dialogue
	else:
		get_tree().paused = UIManager.is_on_dialogue

func update_player_level(new_level):
	%Level.text = "Lvl." + str(new_level)
	
	
func display_objective(objective_description: String):
	%Objective.text = "<" + objective_description + ">"
	$ObjectiveTimer.start()
	%TaskNotif.show()
	
func _on_objective_timer_timeout():
	%TaskNotif.hide()


func display_interaction(interaction_hint, is_hint_visible):
	%Hint.visible = is_hint_visible
	%Hint.text = interaction_hint


func start_dialogue(dialogue_resource, dialogue_start):
	var dialogue = Dialogue.instantiate()
	dialogue.name = "DialogueBox"
	add_child(dialogue)
	dialogue.start(dialogue_resource, dialogue_start)
	
func update_rewards(packet_points, exp_points):
	PlayerData.update_reward(packet_points, exp_points)
	%Packet.text = str(PlayerData.packets)


func _on_settings_btn_pressed():
	SceneManager.is_game_paused = true
	%Settings.show()


func _on_exit_settings_pressed():
	SceneManager.is_game_paused = false
	%Settings.hide()


func _on_continue_pressed():
	SceneManager.is_game_paused = false
	%Settings.hide()


func _on_back_pressed():
	SceneManager.is_game_paused = false
	%HelpPanel.hide()


func _on_help_btn_pressed():
	SceneManager.is_game_paused = true
	%HelpPanel.show()
