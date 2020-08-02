extends Node2D

const SPEED = -300

var width = 0

var sushi_plate = preload("res://Objects/Sushi_Plate.tscn")


func _ready():
	width = $Belt.texture.get_width()


func _process(delta):
	# Endless scrolling
	$Belt.translate(Vector2(SPEED * delta, 0))
	$Belt2.translate(Vector2(SPEED * delta, 0))
	
	if $Belt.position.x <= -width:
		$Belt.position.x = width
	
	if $Belt2.position.x <= -width:
		$Belt2.position.x = width


func _on_Timer_timeout():
	var p = sushi_plate.instance()
	p.set_position($SpawnPosition.get_position())
	add_child(p)
