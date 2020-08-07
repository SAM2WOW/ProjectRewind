extends "res://Scripts/DraggableArea2D.gd"


func _on_Spoon_on_dragging():
	$Spoon_Sound.play()


func _on_Spoon_on_released():
	$Spoon_Sound.play()
