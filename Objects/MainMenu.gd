extends Node


func _ready():
	get_tree().set_pause(true)


func _on_Play_pressed():
	$AnimationPlayer.play("intro")
	$BGM.play()


func _on_AnimationPlayer_animation_finished(anim_name):
	if "intro" in anim_name:
		get_tree().set_pause(false)
