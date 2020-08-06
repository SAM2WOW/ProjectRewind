extends Node2D


var sushi_plate = preload("res://Objects/Sushi/Sushi_Plate.tscn")


func _on_Timer_timeout():
	var p = sushi_plate.instance()
	p.set_position($SpawnPosition.get_position())
	add_child(p)


# Change speed at runtime
# Normally it's -0.156
func change_conveyor_speed(speed: float):
	$Belt.get_material().set_shader_param("speed", speed)
