extends TextureButton

var up_stylebox = preload("res://Arts/Objects/progress_up.tres")
var down_stylebox = preload("res://Arts/Objects/progress_down.tres")


func _on_TextureButton_pressed():
	$Timer.start()
	
	$Pressed.play()


func _on_Timer_timeout():
	pass


# Sync state of button with progress bar
# NEED: optimization so it doesn't run everyframe
func _process(_delta):
	if is_pressed() or is_disabled():
		$"../ProgressBarDown".show()
		$"../ProgressBarUp".hide()
		
		# Change button icon visibility
		$"../Number".set_position(Vector2(-277, -17))
		$"../Icon".set_position(Vector2(-330, -9))
	else:
		$"../ProgressBarDown".hide()
		$"../ProgressBarUp".show()
	
		# Reset Icon Position
		$"../Number".set_position(Vector2(-277, -56))
		$"../Icon".set_position(Vector2(-330, -48))

