extends Area2D


var ready = false

var seaweed_piece = preload("res://Objects/Sushi/Sushi_Piece.tscn")


func _process(_delta):
	var rice_num = $"../Rices".get_child_count()
	
	if rice_num <= 0:
		ready = true


func _on_Bottom_Seaweed_input_event(_viewport, event, _shape_idx):
	var touch = ((event is InputEventScreenTouch) or (event is InputEventMouseButton))
	if ready and touch:
		$Grab.play()
		$AnimationPlayer.play("pick_up")


func _on_Bottom_Seaweed_mouse_entered():
	if ready:
		set_scale(Vector2(1.1, 1.1))


func _on_Bottom_Seaweed_mouse_exited():
	set_scale(Vector2(1, 1))


func _on_AnimationPlayer_animation_finished(anim_name):
	if "pick_up" in anim_name:
		var s = seaweed_piece.instance()
		s.ingredient = Global.INGREDIENT.SEAWEED
		
		# Spawn in cutting board
		get_parent().get_parent().get_parent().add_child(s)
		
		$"../..".bottom_seaweed_rolled()
