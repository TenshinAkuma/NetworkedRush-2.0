extends CharacterBody2D
class_name Player

const ACCELERATION = 900
const FRICTION = 1400
const MAX_SPEED = 150

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	
	if not SceneManager.on_player_spawn.is_connected(player_spawn):
		SceneManager.on_player_spawn.connect(player_spawn)
		
func player_spawn(spawn_point: Vector2, spawn_orientation: Vector2):
	global_position = spawn_point
	animation_tree.set("parameters/idle/blend_position", spawn_orientation)
	
func _physics_process(delta):

	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		
		animation_tree.set("parameters/idle/blend_position", input_vector)
		animation_tree.set("parameters/run/blend_position", input_vector)
		animation_state.travel("run")
		
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		
		animation_state.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity
