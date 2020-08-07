extends Area2D

# For manually setting scrappable
export var forced_scrappable = false

var scrappable = true


func _ready():
	$Sprite.set_rotation_degrees(rand_range(0, 359))
	$Sprite.set_offset(Vector2(rand_range(-5, 5), rand_range(-5, 5)))


func _on_Rice_area_entered(area):
	# Scrap the rice if scrappable
	if "Scrap" in area.name and scrappable and forced_scrappable:
		
		#$AnimationPlayer.play("Scrapped")
		$Tween.interpolate_property(self, "global_position",
			get_global_position(), Global.rice_box_pos, 0.2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		
		$AudioStreamPlayer2D.play()
		
		Global.Console.addPoint(0.01)
	
	# Else Check if anything on top of the rice
	elif "Sushi" in area.name:
		scrappable = false


func _on_Rice_area_exited(area):
	if "Sushi" in area.name:
		scrappable = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if "Scrap" in anim_name:
		queue_free()


func _on_Tween_tween_all_completed():
	queue_free()
