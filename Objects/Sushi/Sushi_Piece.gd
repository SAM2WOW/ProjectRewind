extends "res://Scripts/DraggableArea2D.gd"


export (Global.INGREDIENT) var sushi_type = Global.INGREDIENT.SALMON

var droppable = false

var on_cutting_board = false

# Reference for the dropped box
var box_ref


func _on_Sushi_Piece_on_dragging():
	# Set random rotation
	set_rotation_degrees(rand_range(-20, 20))
	
	$AnimationPlayer.play("pick_up")


# Drop and kill the ingredient 
func _on_Sushi_Piece_on_released():
	# If drop on the box
	if droppable:
		box_ref.dropped()
		queue_free()
	
	# If drop on cutting board
	if on_cutting_board:
		set_original_position(get_position())
		
	$AnimationPlayer.play("drop")


# Check if the box is the right box
# Set droppable to true if it is the right box
func _on_Sushi_Piece_area_entered(area):
	if "Box" in area.name:
		box_ref = area
		
		# Only allow dropping on correct ingredient box
		if area.ingredient == sushi_type:
			droppable = true
	
	if "Cutting_Board" in area.name:
		on_cutting_board = true


func _on_Sushi_Piece_area_exited(area):
	if "Box" in area.name:
		droppable = false
	
	if "Cutting_Board" in area.name:
		on_cutting_board = false
