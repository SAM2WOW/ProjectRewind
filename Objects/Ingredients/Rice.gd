extends Area2D

# For manually setting scrappable
export var forced_scrappable = false

var overlapped = 0
var scrappable = true


func _ready():
	$Sprite.set_rotation_degrees(rand_range(0, 359))
	$Sprite.set_offset(Vector2(rand_range(-5, 5), rand_range(-5, 5)))


func _on_Rice_area_entered(area):
	# Scrap the rice if scrappable
	if "Scrap" in area.name and scrappable and forced_scrappable:
		$CollisionShape2D.call_deferred("set_disabled", true)
		
		#$AnimationPlayer.play("Scrapped")
		$Tween.interpolate_property(self, "global_position",
			get_global_position(), Global.rice_box_pos, 0.2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		
		$AnimationPlayer.play("Scrapped")
		
		$AudioStreamPlayer2D.play()
		
		Global.Console.addPoint(0.01)
	
	# Else Check if anything on top of the rice
	elif "Sushi" in area.name:
		scrappable = false
		overlapped += 1
		$Sprite.set_modulate(Color("cbcbcb"))


func _on_Rice_area_exited(area):
	if "Sushi" in area.name:
		overlapped -= 1
		
		if overlapped == 0:
			scrappable = true
			$Sprite.set_modulate(Color("ffffff"))


func _on_AnimationPlayer_animation_finished(anim_name):
	if "Scrap" in anim_name:
		queue_free()


func _on_Tween_tween_all_completed():
	queue_free()
