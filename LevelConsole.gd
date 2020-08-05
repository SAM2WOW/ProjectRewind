extends Node2D

#export (Global.INGREDIENT) var ingredient = Global.INGREDIENT.SALMON
#Only level related stuff
var testI = [0,1,2,3,5]


func _ready():
	Global.Console = self


func getIng():
	randomize()
	var Ingredient = testI[randi() % 5]
	return Ingredient
