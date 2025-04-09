extends Node2D


var pieces_num = 4

var ingredient = [Global.INGREDIENT.SALMON]
var order = [0, 0, 1, 1, 2, 2]


func _ready():
	# Set all the ingredients
	for i in range(order.size()):
		var sushi = get_node("Actual_Roll/Sushi_Piece" + str(i + 1))
		sushi.ingredient = ingredient[order[i]]
		sushi.change_ingredient()
	
	$Spawn.play()
	
	if Global.Console.frenzy_mode:
		$Fake_Cuttingboard.modulate = Color("848a95")


func finished_unroll():
	# Reset Z Index
	set_z_index(0)
	
	# Hide Cutting Board
	$Fake_Cuttingboard.hide()
	
	# Reparent Ingredients to cutting_board
	for i in get_tree().get_nodes_in_group("roll_ingredients"):
		i.is_draggable = true
		
		# Set z to be on top of roll
		i.set_z_index(11)
		i.set_z_as_relative(false)
		
		var new_pos = i.get_position() + Vector2(0, 212)
		
		Global.reparent(i, get_parent())
		
		i.set_position(new_pos)
		i.set_original_position(new_pos)
		
		i.remove_from_group("roll_ingredients")
	
	# Set all the rice to forced scrappable
	for r in $Actual_Roll/Rices.get_children():
		r.forced_scrappable = true



# Clean parent's occupied bool
# Parent is cutting board
func bottom_seaweed_rolled():
	get_parent().occupied = false
	queue_free()


func show_hint():
	if is_instance_valid($Top_Seaweed):
		$Top_Seaweed/Sprite/AnimationPlayer.play("hint")
		$Top_Seaweed/Blocked.play()
