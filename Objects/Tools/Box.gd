extends Area2D

export (Global.INGREDIENT) var ingredient = Global.INGREDIENT.SALMON

var statu = 0
var space = 0
var filled = 0

#for timer
var outTime = 300
var curTime = 0 #current time, count every 0.2 sec

# For Spawning Graphics
var original_sprite_position = Vector2(-52, 0)
var temp_sprite_location = Vector2(-52, 0)


func _ready():
	$Ani.play("MoveIn")
	ingredient = Global.Console.getIng(9)
	change_button_graphic()
	getNumber()
	$Button/Number.set_text("x"+str(space))
	$Counter.play("ready")


func getNumber():
	if ingredient == Global.INGREDIENT.SEAWEED:
		space = 2
	else:
		space = 3


func dropped():
	spawn_graphic()
	filled += 1
	checkOutput(0)
	
	$Drop.play()


func spawn_graphic():
	var s = Sprite.new()
	s.set_texture(load(Global.ingredient_to_address(ingredient)))
	s.set_scale(Vector2(0.7, 0.7))
	s.set_position(temp_sprite_location)
	s.set_rotation_degrees(rand_range(80.0, 100.0))
	
	temp_sprite_location.x += 52
	
	$boxarea/Sushi_Sprites.add_child(s)


func delete_graphic():
	for i in $boxarea/Sushi_Sprites.get_children():
		i.queue_free()
	
	temp_sprite_location = original_sprite_position


func change_button_graphic():
	# Change button graphics
	var color = Global.ingredient_to_colors(ingredient)
	$Button/TextureButton.set_self_modulate(color)
	$Button/ProgressBarDown.set_modulate(color)
	$Button/ProgressBarUp.set_modulate(color)
	
	# Reset Icon visibility
	$Button/Icon.set_texture(load(Global.ingredient_to_icons(ingredient)))
	$Button/Icon.show()


func checkOutput(_forced):
	$Button/Number.set_text("x"+str(space-filled))
	if filled >= space:
		statu = 1
		$Button/Number.set_text("DONE")
	if statu == 1 and _forced == 1:
		output()


func output():
	get_node("Button/TextureButton").disabled = true
	curTime = 0
	get_node("CollisionShape2D").disabled = true
	get_parent().countOutput(ingredient,statu)
	$Ani.play("Output")
	statu = 0
	swipe()


func swipe():
	# Hide Icon and text
	$Button/Number.set_text("")
	$Button/Icon.hide()
	
	get_node("CollisionShape2D").disabled = false
	filled = 0
	ingredient = Global.Console.getIng(ingredient)
	getNumber()



func _on_Ani_animation_finished(anim_name):
	if anim_name == "Output":
		#output()
		delete_graphic()
		change_button_graphic()
		$Button/Number.set_text("x"+str(space))
		$Ani.play("MoveIn")
		$rec.hide()
	if anim_name == "MoveIn":
		$Timeout.start()
		get_node("Button/TextureButton").disabled = false
		
		# Reset Progress Bar Visibilty
		$"Button/ProgressBarUp".show()
		$"Button/ProgressBarDown".hide()

		# Reset Icon Position
		$Button/Number.set_position(Vector2(-277, -56))
		$Button/Icon.set_position(Vector2(-330, -48))


func _on_TextureButton_pressed():
	if statu == 1:
		get_parent().forceOutput()
	else:
		output()


func _on_TextureButton_button_down():
		if statu == 1:
			get_parent().checkOutput(statu)
		popUp()

		
func popUp():
		if statu == 0:
			$Counter.play("NotReady")
			$popTimer.start()
		if statu == 1:
			$Counter.play("ready")
		$Pop.play("in")
		$rec.show()


func _on_Timeout_timeout():
	curTime += 1
	if curTime >= outTime:
		popUp()
		output()
		$Timeout.stop()
		curTime = 0
		
	elif curTime >= 260:
		var dx = rand_range(21,-21)
		var dy = rand_range(18,-18)
		$boxarea/back_of_box.set_offset(Vector2(dx,dy))
		$boxarea/front_of_box.set_offset(Vector2(dx,dy))
		
	elif curTime >= 220:
		if curTime%10 <=6:
			var dx = rand_range(18,-18)
			var dy = rand_range(14,-14)
			$boxarea/back_of_box.set_offset(Vector2(dx,dy))
			$boxarea/front_of_box.set_offset(Vector2(dx,dy))
			
	elif curTime >= 150:
		if curTime%18 <= 8 and curTime%2 == 0:
			var dx = rand_range(14,-14)
			var dy = rand_range(12,-12)
			$boxarea/back_of_box.set_offset(Vector2(dx,dy))
			$boxarea/front_of_box.set_offset(Vector2(dx,dy))
	
	$Button/ProgressBarDown.set_value(curTime)
	$Button/ProgressBarUp.set_value(curTime)


func _on_popTimer_timeout():
	$rec.hide()
