extends Node2D

#export (Global.INGREDIENT) var ingredient = Global.INGREDIENT.SALMON
#Only level related stuff
var testI = [0,1,5]


func _ready():
	Global.Console = self


func getIng():
	randomize()
	var Ingredient = testI[randi()%3]
	return Ingredient
