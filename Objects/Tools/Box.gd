extends Area2D


export (Global.INGREDIENT) var ingredient = Global.INGREDIENT.SALMON
var statu = 0
var space = 0
var filled = 0


func _ready():
	$Ani.play("MoveIn")
	ingredient = Global.Console.getIng()
	$Label.set_text(Global.INGREDIENT.keys()[ingredient])
	getNumber()

func getNumber():
	if ingredient == 0 or ingredient == 1 or ingredient == 2 or ingredient == 3:
		space = 3
	else:
		space = 2

func dropped():
	print("Hey you dropped the ingredient! Nice")
	filled += 1
	checkOutput()

func checkOutput():
	if filled >= space:
		statu = 1
		output()

func output():
	get_parent().countOutput(ingredient,statu)
	$Ani.play("New Anim")
	statu = 0
	swipe()


func swipe():
	filled = 0
	self.ingredient = Global.Console.getIng()
	print(Global.INGREDIENT.keys()[ingredient])
	$Label.set_text(Global.INGREDIENT.keys()[ingredient])


func _on_Ani_animation_finished(anim_name):
	if anim_name == "New Anim":
		#output()
		$Ani.play("MoveIn")
