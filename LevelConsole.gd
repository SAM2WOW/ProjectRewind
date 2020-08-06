extends Node2D

#export (Global.INGREDIENT) var ingredient = Global.INGREDIENT.SALMON
#Only level related stuff

var testI = [0,1,2,3,5]
var money = 0



func _ready():
	Global.Console = self

#func _process(delta):
#	pass

func getIng():
	randomize ( )
	var Ingredient = testI[randi()%5]
  
	return Ingredient


func minusPoint(type):
	var point = 0
	if type == 0:
		point = 1
	if type == 1:
		point = 2
	money -= point
	$Money.set_text(str(money))
	
func addPoint(_point):
	if _point != null:
		money += _point
	else:
		money += 1
	$Money.set_text(str(money))

