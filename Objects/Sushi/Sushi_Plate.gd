extends Node2D


const COLORS_LIST = ["22b2ea", "f2786d", "f2a341", "d9b607", "888c07", "cecece"]

const SPEED = -300

var is_sushi_dragging = false


func _ready():
	# Random plate colors
	$Plate.set_modulate(Color(COLORS_LIST[randi() % 6]))


func _process(delta):
	# Move the plate
	if is_sushi_dragging == false:
		position += Vector2(SPEED * delta, 0)
		
	# Delete plate if out of screen
	if global_position.x <= -155:
		queue_free()


func _on_Sushi_on_dragging():
	is_sushi_dragging = true
	
	$Plate.set_self_modulate(Color("70ffffff"))


func _on_Sushi_on_released():
	is_sushi_dragging = false
	
	$Plate.set_self_modulate(Color("ffffff"))


func _on_Base_Plate_area_entered(area):
	# Flip the plate when touch spoons
	if "Scrap" in area.name:
		$PlateAnimation.play("flip")
		$Flip_Sound.play()
		
		Global.Console.minusPoint($Drag_Plate.type)
		
		# Do once
		$Base_Plate.queue_free()


func _on_PlateAnimation_animation_finished(anim_name):
	if "flip" in anim_name:
		queue_free()
