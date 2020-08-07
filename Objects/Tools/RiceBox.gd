extends Area2D


var ingredient = Global.INGREDIENT.RICE


func dropped():
	Global.Console.addPoint(0.3)
