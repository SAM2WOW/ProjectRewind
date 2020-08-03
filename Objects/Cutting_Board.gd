extends Area2D


var occupied = false

var nigiri = preload("res://Objects/Sushi_Scenes/Nigiri.tscn")


# Spawn sushi based on type
func spawn_sushi(type, recipe):
	occupied = true
	
	match type:
		Global.S_TYPE.NIGIRI:
			print("Nigiri sushi created")
			var n = nigiri.instance()
			n.ingredient = recipe[0]
			add_child(n)
		Global.S_TYPE.ROLL:
			print("Roll sushi created")
			pass
