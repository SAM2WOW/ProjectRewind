extends Area2D


export (Global.INGREDIENT) var ingredient = Global.INGREDIENT.SALMON

# Called when the node enters the scene tree for the first time.
func _ready():
	$Ani.play("MoveIn")
	self.ingredient = Global.Console.getIng()
	print(Global.INGREDIENT.keys()[ingredient])
	$Label.set_text(Global.INGREDIENT.keys()[ingredient])
	pass # Replace with function body.


func dropped():
	print("Hey you dropped the ingredient! Nice")
	output()
	
	
func output():
	$Ani.play("New Anim")
	swipe()
	
func swipe():
	self.ingredient = Global.Console.getIng()
	print(Global.INGREDIENT.keys()[ingredient])
	$Label.set_text(Global.INGREDIENT.keys()[ingredient])

func _on_Ani_animation_finished(anim_name):
	if anim_name == "New Anim":
		#output()
		$Ani.play("MoveIn")
