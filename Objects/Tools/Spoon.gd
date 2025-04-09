extends "res://Scripts/DraggableArea2D.gd"


var enabled = false

func _on_Spoon_on_dragging():
	$Spoon_Sound.play()
	enabled = true


func _on_Spoon_on_released():
	$Spoon_Sound.play()
	enabled = false
