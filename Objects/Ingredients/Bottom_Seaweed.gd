extends "res://Objects/Sushi/Sushi_Piece.gd"


func _process(_delta):
	var rice_num = $"../Rices".get_child_count()
	
	if rice_num <= 0:
		is_draggable = true


func _on_Bottom_Seaweed_on_dragging():
	$Seaweed.play()


func _on_Bottom_Seaweed_on_released():
	$B_Released.play()
