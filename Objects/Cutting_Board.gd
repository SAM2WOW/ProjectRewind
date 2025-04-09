extends Area2D


var occupied = false

var nigiri = preload("res://Objects/Sushi_Scenes/Nigiri.tscn")
var roll = preload("res://Objects/Sushi_Scenes/Roll.tscn")

var last_roll

# Spawn sushi based on type
func spawn_sushi(type, recipe):


	match type:
		Global.S_TYPE.NIGIRI:
			var n = nigiri.instance()
			n.ingredient = recipe[0]


			Global.Console.minusPoint(type)
			n.set_position(get_local_mouse_position())


			add_child(n)
			
		Global.S_TYPE.ROLL:
			occupied = true
			
			last_roll = roll.instance()
			last_roll.ingredient = recipe
			last_roll.set_position(Vector2(0, 212))
			Global.Console.minusPoint(type)
			add_child(last_roll)


func show_occupied_hint():
	last_roll.show_hint()
