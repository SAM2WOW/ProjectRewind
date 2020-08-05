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
		print(ingredient)


func finished_unroll():
	# Reparent Ingredients to cutting_board
	for i in get_tree().get_nodes_in_group("roll_ingredients"):
		i.is_draggable = true
		Global.reparent(i, get_parent())


# Clean parent's occupied bool
# Parent is cutting board
func _on_Bottom_Seaweed_on_dropped():
	get_parent().occupied = false
	queue_free()
