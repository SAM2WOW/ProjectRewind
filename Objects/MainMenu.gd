extends Node


func _ready():
	get_tree().set_pause(true)
	
	$AnimationPlayer.play("menu_intro")


func _on_Play_pressed():
	$AnimationPlayer.play("scene_intro")
	$BGM.play()


func _on_AnimationPlayer_animation_finished(anim_name):
	if "scene" in anim_name:
		get_tree().set_pause(false)
		


# Settings

func _on_Music_toggled(button_pressed):
	AudioServer.set_bus_mute(2, not button_pressed)


func _on_Sounds_toggled(button_pressed):
	AudioServer.set_bus_mute(1, not button_pressed)
