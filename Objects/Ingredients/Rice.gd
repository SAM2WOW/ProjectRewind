extends Area2D


func _ready():
	$Sprite.set_rotation_degrees(rand_range(0, 359))
	$Sprite.set_offset(Vector2(rand_range(-5, 5), rand_range(-5, 5)))


func _on_Rice_area_entered(area):
	if "Scrap" in area.name:
		$AnimationPlayer.play("Scrapped")


func _on_AnimationPlayer_animation_finished(anim_name):
	if "Scrap" in anim_name:
		queue_free()
