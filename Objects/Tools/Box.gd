extends Area2D

export (Global.INGREDIENT) var ingredient = Global.INGREDIENT.SALMON

var statu = 0
var space = 0
var filled = 0

#for timer
var outTime = 300
var curTime = 0 #current time, count every 0.2 sec

# For Spawning Graphics
var original_sprite_position = Vector2(-60, -8)
var temp_sprite_location = Vector2(-60, -8)


func _ready():
	$Ani.play("MoveIn")
	ingredient = Global.Console.getIng(9)
	$Label.set_text(Global.INGREDIENT.keys()[ingredient])
	getNumber()
	$Number.set_text("x"+str(space))


func getNumber():
	if ingredient == Global.INGREDIENT.SEAWEED:
		space = 2
	else:
		space = 3


func dropped():
	spawn_graphic()
	filled += 1
	checkOutput(0)


func spawn_graphic():
	var s = Sprite.new()
	s.set_texture(load(Global.ingredient_to_address(ingredient)))
	s.set_scale(Vector2(0.7, 0.7))
	s.set_position(temp_sprite_location)
	s.set_rotation_degrees(rand_range(80.0, 100.0))
	
	temp_sprite_location.x += 30
	
	$boxarea/Sushi_Sprites.add_child(s)


func delete_graphic():
	for i in $boxarea/Sushi_Sprites.get_children():
		i.queue_free()
	
	temp_sprite_location = original_sprite_position


func checkOutput(_forced):
	$Number.set_text("x"+str(space-filled))
	if filled >= space:
		statu = 1
	if statu == 1 and _forced == 1:
		output()


func output():
	curTime = 0
	get_node("CollisionShape2D").disabled = true
	get_parent().countOutput(ingredient,statu)
	$Ani.play("Output")
	statu = 0
	swipe()


func swipe():
	get_node("CollisionShape2D").disabled = false
	filled = 0
	ingredient = Global.Console.getIng(ingredient)
	getNumber()
	$Label.set_text(Global.INGREDIENT.keys()[ingredient])
	$Number.set_text("x"+str(space))


func _on_Ani_animation_finished(anim_name):
	if anim_name == "Output":
		#output()
		delete_graphic()
		$Ani.play("MoveIn")
	if anim_name == "MoveIn":
		$Timeout.start()


func _on_TextureButton_pressed():
	if statu == 1:
		get_parent().forceOutput()
	else:
		output()


func _on_TextureButton_button_down():
		get_parent().checkOutput(statu)


func _on_Timeout_timeout():
	curTime += 1
	
	if curTime >= outTime:
		output()
		$Timeout.stop()
		curTime = 0
		
	elif curTime >= 240:
		if curTime%10 <=7:
			var dx = rand_range(20,-20)
			var dy = rand_range(20,-20)
			$boxarea/back_of_box.set_offset(Vector2(dx,dy))
			$boxarea/front_of_box.set_offset(Vector2(dx,dy))
			
	elif curTime >= 160:
		if curTime%18 <= 8 and curTime%2 == 0:
			var dx = rand_range(12,-12)
			var dy = rand_range(12,-12)
			$boxarea/back_of_box.set_offset(Vector2(dx,dy))
			$boxarea/front_of_box.set_offset(Vector2(dx,dy))
	
	$ProgressBar.set_value(curTime)
