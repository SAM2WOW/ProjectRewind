extends Area2D


var occupied = false


# Spawn sushi based on type
func spawn_sushi(type, recipe):
	occupied = true
	
	match type:
		Global.S_TYPE.NIGIRI:
			print("Nigiri sushi created")
			pass
		Global.S_TYPE.ROLL:
			print("Roll sushi created")
			pass
