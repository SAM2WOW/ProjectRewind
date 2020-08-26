extends Area2D

signal on_dragging
signal on_released

const FOLLOW_SPEED = 20.0

var is_mouse_hover: bool  = false
var is_dragging: bool = false

# The position to return to when dropping failed
var original_position: Vector2

# Decided wheather this thing is dragable right now
export var is_draggable = true


func _ready():
	original_position = get_position()


func _input(event):
	# Check for touch
	var touch = event is InputEventScreenTouch
	var pressed_state = event.is_pressed()
	
	# Turn on dragging when mouse clicked on the area
	if is_mouse_hover and (Input.is_action_just_pressed("touch") or (touch and pressed_state)) and is_draggable:
		is_dragging = true
		
		Global.mouse_selected = true
		emit_signal("on_dragging")
		
	if is_dragging and (Input.is_action_just_released("touch") or (touch and not pressed_state)):
		is_dragging = false
		
		Global.mouse_selected = false
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
	
	if is_draggable:
		set_scale(Vector2(1.1, 1.1))

func _on_Sushi_Piece_mouse_exited():
	is_mouse_hover = false
	set_scale(Vector2(1, 1))


# Set the original position to new location
func set_original_position(position: Vector2):
	original_position = position
