extends Node2D


var pieces_num = 4

var ingredient = Global.INGREDIENT.SALMON


func _ready():
	pass # Replace with function body.


# Clean parent's occupied bool
# Parent is cutting board
func _on_Bottom_Seaweed_on_dropped():
	get_parent().occupied = false
	queue_free()
