extends Node2D

const SPEED = -300

# Changed the width slightly shorter so the seam would dissapear
const WIDTH = 1912

var sushi_plate = preload("res://Objects/Sushi/Sushi_Plate.tscn")


func _on_Timer_timeout():
	var p = sushi_plate.instance()
	p.set_position($SpawnPosition.get_position())
	add_child(p)
