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
		
		Global.mouse_selected = true
		emit_signal("on_dragging")
		
	if is_dragging and Input.is_action_just_released("touch"):
		is_dragging = false
		
		Global.mouse_selected = false
		emit_signal("on_released")


func _process(_delta):	
	if is_dragging == true:
		var new_pos = get_global_mouse_position().y - get_parent().get_global_position().y
		new_pos = clamp(new_pos, -455, 0)
		
		# Change Position
		set_position(Vector2(0, new_pos))
		
		# Change Size
		set_scale(Vector2(1, (new_pos + 455) / 455))
		
		# Change roll size
		$"../Actual_Roll".set_scale(Vector2(1, new_pos / -455))
		
		# When finished unrolling
		if get_scale().y <= 0.01:
			get_parent().finished_unroll()
			queue_free()


# Check if mouse is hovering
func _on_Top_Seaweed_mouse_entered():
	is_mouse_hover = true
	set_scale(Vector2(1.1, 1.1))


func _on_Top_Seaweed_mouse_exited():
	is_mouse_hover = false
	set_scale(Vector2(1, 1))
