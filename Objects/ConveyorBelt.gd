extends Node2D

const SPEED = -300

# Changed the width slightly shorter so the seam would dissapear
const WIDTH = 1912

var sushi_plate = preload("res://Objects/Sushi/Sushi_Plate.tscn")


func _process(delta):
	"""
	# Endless scrolling
	$Belt.translate(Vector2(SPEED * delta, 0))
	$Belt2.translate(Vector2(SPEED * delta, 0))
	
	if $Belt.position.x <= -WIDTH:
		$Belt.position.x = WIDTH
	
	if $Belt2.position.x <= -WIDTH:
		$Belt2.position.x = WIDTH
	"""


func _on_Timer_timeout():
	var p = sushi_plate.instance()
	p.set_position($SpawnPosition.get_position())
	add_child(p)


func _on_HSlider_value_changed(value):
	$Belt.get_material().set_shader_param("speed",value)
	$Label.set_text(str(value))
