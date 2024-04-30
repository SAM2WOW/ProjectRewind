extends "res://Scripts/DraggableArea2D.gd"


var droppable = false

var board_ref

# Define what type of sushi
var type = Global.S_TYPE.ROLL

# For Nigiri recipe: [meat]
# For Roll recipe: [ingredient1, ingredient2, ingredient3...]
var recipe = [Global.INGREDIENT.SALMON, Global.INGREDIENT.CUCUMBER, Global.INGREDIENT.RADISH]


func _ready():
	# Randomize Orders
	if Global.Console.frenzy_mode:
		type = Global.S_TYPE.NIGIRI
	else:
		type = randi() % Global.S_TYPE.size()
	
	# Randomize Ingredients
	match type:
		Global.S_TYPE.NIGIRI:
			recipe[0] = randi() % 4
			$Meat.set_texture(load(Global.ingredient_to_address(recipe[0])))
			
		Global.S_TYPE.ROLL:
			for i in range(3):
				recipe[i] = randi() % 4
			
			# Change visibility and maki roll graphic
			$Meat.hide()
			$Rice.hide()
			$Rolls.show()
			
			# Set roll top color to match the recipe
			$Rolls/Top1.set_modulate(Global.ingredient_to_colors(recipe[0]))
			$Rolls/Top2.set_modulate(Global.ingredient_to_colors(recipe[1]))
			$Rolls/Top3.set_modulate(Global.ingredient_to_colors(recipe[2]))


func _on_Drag_Plate_on_dragging():
	$AnimationPlayer.play("pick_up")
	$Grab_Sound.play()


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
