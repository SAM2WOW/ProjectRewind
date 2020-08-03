extends "res://Scripts/DraggableArea2D.gd"


export (Global.INGREDIENT) var sushi_type = Global.INGREDIENT.SALMON

var droppable = false

# Reference for the dropped box
var box_ref


# Drop and kill the ingredient 
func _on_Sushi_Piece_on_released():
	if droppable == true:
		box_ref.dropped()
		queue_free()


# Check if the box is the right box
# Set droppable to true if it is the right box
func _on_Sushi_Piece_area_entered(area):
	if "Box" in area.name:
		box_ref = area
		
		if area.ingredient == sushi_type:
			droppable = true


func _on_Sushi_Piece_area_exited(area):
	droppable = false
