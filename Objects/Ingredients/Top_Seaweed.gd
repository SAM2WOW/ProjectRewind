extends Area2D

signal on_dragging
signal on_released

const FOLLOW_SPEED = 20.0

var is_dragging: bool = false

# The position to return to when dropping failed
var original_position: Vector2

var is_draggable = true


func _ready():
	original_position = get_position()
	$AnimationPlayer.play("spawn")


func _on_Top_Seaweed_input_event(_viewport, event, _shape_idx):
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


func _process(_delta):	
	if is_dragging == true:
		var new_pos = get_global_mouse_position().y - get_parent().get_global_position().y
		new_pos = clamp(new_pos, -455, 0)
		
		# Change Position
		set_position(Vector2(0, new_pos))
		
		# Change Size
		set_scale(Vector2(1, (new_pos + 455) / 455))
		
		# When finished unrolling
		if get_scale().y <= 0.2:
			is_dragging = false
			is_draggable = false
			$AnimationPlayer.play("auto_roll")
		
		


# Check if mouse is hovering
func _on_Top_Seaweed_mouse_entered():
	if is_draggable:
		$Sprite.set_scale(Vector2(1.1, 1.1))


func _on_Top_Seaweed_mouse_exited():
	$Sprite.set_scale(Vector2(1, 1))


func _on_AnimationPlayer_animation_finished(anim_name):
	if "spawn" in anim_name:
		$Roll.hide()
		$Roll2.hide()
		$Roll3.hide()
		is_draggable = true
	
	if "auto_roll" in anim_name:
		get_parent().finished_unroll()
		queue_free()


func _on_Top_Seaweed_on_dragging():
	$Grab.play()


func _on_Top_Seaweed_on_released():
	$Released.play()
