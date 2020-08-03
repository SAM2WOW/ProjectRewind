extends Area2D


export (Global.INGREDIENT) var ingredient = Global.INGREDIENT.SALMON


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func dropped():
	print("Hey you dropped the ingredient! Nice")
