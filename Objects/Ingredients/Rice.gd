extends Area2D


var scrappable = true


func _ready():
	$Sprite.set_rotation_degrees(rand_range(0, 359))
	$Sprite.set_offset(Vector2(rand_range(-5, 5), rand_range(-5, 5)))


func _on_Rice_area_entered(area):
	# Scrap the rice if scrappable
	if scrappable and "Scrap" in area.name:
		$AnimationPlayer.play("Scrapped")
	
	# Else Check if anything on top of the rice
	elif "Sushi" in area.name:
		scrappable = false


func _on_Rice_area_exited(area):
	if "Sushi" in area.name:
		scrappable = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if "Scrap" in anim_name:
		queue_free()
