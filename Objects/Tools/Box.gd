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
	$Number.set_text("x"+str(space))

func getNumber():
	if ingredient == 5:
		space = 2
	else:
		space = 3

func dropped():
	print("Hey you dropped the ingredient! Nice")
	filled += 1
	checkOutput(0)


func checkOutput(_forced):
	$Number.set_text("x"+str(space-filled))
	if filled >= space:
		statu = 1
	if statu == 1 and _forced == 1:
		output()


func output():
	get_node("CollisionShape2D").disabled = true
	get_parent().countOutput(ingredient,statu)
	$Ani.play("New Anim")
	statu = 0
	swipe()


func swipe():
	$Number.set_text("x"+str(space))
	get_node("CollisionShape2D").disabled = false
	filled = 0
	self.ingredient = Global.Console.getIng()
	print(Global.INGREDIENT.keys()[ingredient])
	$Label.set_text(Global.INGREDIENT.keys()[ingredient])


func _on_Ani_animation_finished(anim_name):
	if anim_name == "New Anim":
		#output()
		$Ani.play("MoveIn")


func _on_TextureButton_pressed():
	if statu == 1:
		get_parent().forceOutput()
	else:
		output()
 # Replace with function body.


func _on_TextureButton_button_down():
		get_parent().checkOutput(statu)
 # Replace with function body.
