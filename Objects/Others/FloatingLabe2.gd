extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if value == 1:
		$Label.set_text("0"+" COMBO")
		$Anim.play("out") # Replace with function body.
	if value == 2:
		$Label.set_text("2x"+" COMBO!!")
		$Anim.play("out2") 
	if value == 3:
		$Label.set_text("3x"+" COMBO!!!")
		$Anim.play("out3") 
 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
