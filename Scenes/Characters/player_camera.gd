extends Camera2D


@onready var top_left = $Limits/TopLeft
@onready var bottom_right = $Limits/BottomRIght

# Called when the node enters the scene tree for the first time.
func _ready():
	limit_top = top_left.global_position.y
	limit_left = top_left.global_position.x
	limit_bottom = bottom_right.global_position.y
	limit_right = bottom_right.global_position.x
