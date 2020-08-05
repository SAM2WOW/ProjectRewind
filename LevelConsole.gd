extends Node2D

#export (Global.INGREDIENT) var ingredient = Global.INGREDIENT.SALMON
#Only level related stuff
var testI = [0,4,5]
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.Console = self



#func _process(delta):
#	pass

func getIng():
	var Ingredient = testI[randi()%3]
	return Ingredient
