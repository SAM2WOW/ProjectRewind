extends Area2D

signal on_dragging
signal on_released

const FOLLOW_SPEED = 20.0

var is_mouse_hover: bool  = false
var is_dragging: bool = false

# The position to return to when dropping failed
var original_position: Vector2


func _ready():
	original_position = get_position()


func _input(_event):
	# Turn on dragging when mouse clicked on the area
	if is_mouse_hover and Input.is_action_just_pressed("touch"):
		is_dragging = true
		emit_signal("on_dragging")
	elif is_mouse_hover and Input.is_action_just_released("touch"):
		is_dragging = false
		emit_signal("on_released")


func _process(delta):	
	# Drag the object
	if is_dragging == true:
		var mouse_pos = get_global_mouse_position()
		set_global_position(mouse_pos)
	else:
		set_position(position.linear_interpolate(original_position, delta * FOLLOW_SPEED))


# Check if mouse is hovering
func _on_Sushi_Piece_mouse_entered():
	is_mouse_hover = true

func _on_Sushi_Piece_mouse_exited():
	is_mouse_hover = false


# Set the original position to new location
func set_original_position(position: Vector2):
	original_position = position
