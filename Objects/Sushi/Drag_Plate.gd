extends "res://Scripts/DraggableArea2D.gd"


var droppable = false

var board_ref

# Define what type of sushi
var type = Global.S_TYPE.ROLL

# For Nigiri recipe: [meat]
# For Roll recipe: [ingredient1, ingredient2, ingredient3...]
var recipe = [Global.INGREDIENT.SALMON, Global.INGREDIENT.CUCUMBER]


func _on_Drag_Plate_on_dragging():
	$AnimationPlayer.play("pick_up")


func _on_Drag_Plate_on_released():
	if droppable and not board_ref.occupied:
		board_ref.spawn_sushi(type, recipe)
		get_parent().queue_free()


func _on_Drag_Plate_area_entered(area):
	if "Cutting_Board" in area.name:
		board_ref = area
		droppable = true


func _on_Drag_Plate_area_exited(area):
	if "Cutting_Board" in area.name:
		droppable = false
