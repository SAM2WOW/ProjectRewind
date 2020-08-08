extends TextureButton

var up_stylebox = preload("res://Arts/Objects/progress_up.tres")
var down_stylebox = preload("res://Arts/Objects/progress_down.tres")


func _on_TextureButton_pressed():
	$Timer.start()


func _on_Timer_timeout():
	
	$"../ProgressBarUp".show()
	$"../ProgressBarDown".hide()


func _on_TextureButton_button_down():
	$"../ProgressBarUp".hide()
	$"../ProgressBarDown".show()
