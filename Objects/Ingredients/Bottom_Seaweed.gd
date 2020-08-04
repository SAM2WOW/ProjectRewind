extends "res://Objects/Sushi/Sushi_Piece.gd"


func _process(delta):
	var rice_num = $"../Rices".get_child_count()
	
	if rice_num <= 0:
		is_draggable = true
