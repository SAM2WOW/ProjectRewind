extends Node


func _ready():
	get_tree().set_pause(true)
	
	$AnimationPlayer.play("menu_intro")


func _on_Play_pressed():
	$Tap_Sound.play()
	$AnimationPlayer.play("scene_intro")
	$BGM.play()


func _on_AnimationPlayer_animation_finished(anim_name):
	if "scene_intro" in anim_name:
		get_tree().set_pause(false)
		$Timer.start()


# Game Over
func _on_Timer_timeout():
	get_tree().set_pause(true)
	
	$Menu.hide()
	
	$AnimationPlayer.play("game_over")


# Settings
func _on_Music_toggled(button_pressed):
	AudioServer.set_bus_mute(2, not button_pressed)
	$Tap_Sound.play()

func _on_Sounds_toggled(button_pressed):
	AudioServer.set_bus_mute(1, not button_pressed)
	$Tap_Sound.play()


# Timer
func _process(_delta):
	var time_remain = int($Timer.get_time_left())
	var seconds = time_remain % 60
	var minutes = time_remain / 60
	#print(minutes, " ", seconds)
	$"CanvasLayer/HUD/CenterContainer2/Time".set_text("%02d:%02d" % [minutes, seconds])
