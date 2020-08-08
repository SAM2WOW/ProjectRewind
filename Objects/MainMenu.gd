extends Node

var rank_range = [-1000000, -1500, -1000, -500, 0, 1000, 2000, 3000, 4000, 8000, 10000, 20000, 30000, 1000000]
var rank_name = ["Company Destoryer", "Going Bankrupt", "Big Oof", "What Happened?", "What Happened?", "Sushi Amature", "Sushi Unroller", "Sushi Chef", "Sushi Master", "Sushi Killer", "Sushi Senpai", "Sushi Kami", "How did u even get this high?"]


func _ready():
	get_tree().set_pause(true)
	
	$AnimationPlayer.play("menu_intro")


func _on_Play_pressed():
	$Tap_Sound.play()
	$AnimationPlayer.play("scene_intro")


func _on_AnimationPlayer_animation_finished(anim_name):
	if "scene_intro" in anim_name:
		get_tree().set_pause(false)
		$Timer.start()
		$BGM.play()
	
	elif "menu_outro" in anim_name:
		get_tree().reload_current_scene()


# Game Over
func _on_Timer_timeout():
	get_tree().set_pause(true)
	
	$Menu.hide()
	$Game_Over.show()
	
	# Setting the game over screen
	$"Game_Over/CenterContainer/VBoxContainer/Salary".set_text("Salary: %d¥" % (Global.Console.money * 100))
	$"Game_Over/CenterContainer/VBoxContainer/Rank".set_text("Rank: %s" % ranking(Global.Console.money * 100))
	
	$AnimationPlayer.play("game_over")


func ranking(score):
	var index = rank_range.bsearch(score)
	return rank_name[index - 1]


# Reload Scene
func _on_Continue_pressed():
	$AnimationPlayer.play("menu_outro")


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
	$"CanvasLayer/HUD/CenterContainer2/Time".set_text("%02d:%02d" % [minutes, seconds])


# Pause Game
func _on_Pause_toggled(button_pressed):
	if button_pressed:
		get_tree().set_pause(true)
		$"CanvasLayer/HUD/HBoxContainer/Reload".show()
		
		$Tap_Sound.play()
		
		var big_text = get_node("CanvasLayer/HUD/CenterContainer/Label")
		big_text.set_text("PAUSED")
		big_text.set_scale(Vector2(1, 1))
		big_text.set_modulate(Color("ffffff"))
		
		$Node2D/ConveyorBelt.change_conveyor_speed(0)
		
	else:
		get_tree().set_pause(false)
		$"CanvasLayer/HUD/HBoxContainer/Reload".hide()
		
		$Tap_Sound.play()
		
		var big_text = get_node("CanvasLayer/HUD/CenterContainer/Label")
		big_text.set_modulate(Color("00ffffff"))
		
		$Node2D/ConveyorBelt.change_conveyor_speed(-0.156)


# Reload
func _on_Reload_pressed():
	get_tree().reload_current_scene()
