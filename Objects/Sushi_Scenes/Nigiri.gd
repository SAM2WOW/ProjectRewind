extends Node2D


var pieces_num = 2

var ingredient = Global.INGREDIENT.SALMON


func _ready():
	$Sushi_Piece.ingredient = ingredient
	$Sushi_Piece.change_ingredient()


func _on_Sushi_Piece_on_dropped():
	pieces_num -= 1
	check_finished()


func _on_Sushi_Piece2_on_dropped():
	pieces_num -= 1
	check_finished()


# Clean parent's occupied bool
# Parent is cutting board
func check_finished():
	if pieces_num <= 0:
		get_parent().occupied = false
		queue_free()
