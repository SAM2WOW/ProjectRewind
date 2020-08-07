extends Area2D

var is_mouse_hover  = false

var ready = false

var seaweed_piece = preload("res://Objects/Sushi/Sushi_Piece.tscn")


func _process(_delta):
	var rice_num = $"../Rices".get_child_count()
	
	if rice_num <= 0:
		ready = true


func _input(_event):
	if is_mouse_hover and Input.is_action_just_pressed("touch"):
		$Grab.play()
		$AnimationPlayer.play("pick_up")


func _on_Bottom_Seaweed_mouse_entered():
	if ready:
		is_mouse_hover = true
		set_scale(Vector2(1.1, 1.1))


func _on_Bottom_Seaweed_mouse_exited():
	is_mouse_hover = false
	set_scale(Vector2(1, 1))


func _on_AnimationPlayer_animation_finished(anim_name):
	if "pick_up" in anim_name:
		var s = seaweed_piece.instance()
		s.ingredient = Global.INGREDIENT.SEAWEED
		
		# Spawn in cutting board
		get_parent().get_parent().get_parent().add_child(s)
		
		$"../..".bottom_seaweed_rolled()
