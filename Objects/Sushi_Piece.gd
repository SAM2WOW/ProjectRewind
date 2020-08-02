extends Area2D


const FOLLOW_SPEED = 20.0

var is_mouse_hover: bool  = false
var is_dragging: bool = false

# The position to return to when dropping failed
var original_position: Vector2


func _ready():
	original_position = get_global_position()


func _process(delta):
	# Turn on dragging when mouse clicked on the area
	if is_mouse_hover and Input.is_action_just_pressed("touch"):
		is_dragging = true
		$AnimationPlayer.play("pick_up")
	elif Input.is_action_just_released("touch"):
		is_dragging = false
	
	# Drag the object
	if is_dragging == true:
		var mouse_pos = get_global_mouse_position()
		set_global_position(position.linear_interpolate(mouse_pos, delta * FOLLOW_SPEED))


# Check if mouse is hovering
func _on_Sushi_Piece_mouse_entered():
	is_mouse_hover = true
	$AnimationPlayer.play("hovering")

func _on_Sushi_Piece_mouse_exited():
	is_mouse_hover = false
	$AnimationPlayer.play_backwards("hovering")
