extends Area2D

signal on_dragging
signal on_released

const FOLLOW_SPEED = 20.0

var is_dragging: bool = false

var mouse_pos = Vector2(0, 0)

# The position to return to when dropping failed
var original_position: Vector2

# Decided wheather this thing is dragable right now
export var is_draggable = true


func _ready():
	original_position = get_position()
	
	connect("input_event", self, "_on_input_event")
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")


func _on_input_event(_viewport, event, _shape_idx):
	# Check for touch
	var touch = ((event is InputEventScreenTouch) or (event is InputEventMouseButton))
	
	if is_draggable and touch:
		# Turn on dragging when mouse clicked on the area
		if event.is_pressed():
			is_dragging = true
			
			Global.mouse_selected = true
			emit_signal("on_dragging")
			
		if is_dragging and not event.is_pressed():
			is_dragging = false
			
			Global.mouse_selected = false
			emit_signal("on_released")


func _process(delta):	
	# Drag the object
	if is_dragging == true:
		set_global_position(get_global_mouse_position())
	else:
		set_position(position.linear_interpolate(original_position, delta * FOLLOW_SPEED))


# Check if mouse is hovering
func _on_mouse_entered():
	if is_draggable:
		set_scale(Vector2(1.1, 1.1))

func _on_mouse_exited():
	set_scale(Vector2(1, 1))


# Set the original position to new location
func set_original_position(position: Vector2):
	original_position = position
