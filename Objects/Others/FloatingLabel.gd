extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if value > 0:
		$Label.set_text("+"+str(value*100))
	elif value < 0:
		$Label.set_text(str(value*100))
	else:
		$Label.set_text(str(value*100))
	$Anim.play("out") # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Anim_animation_finished(_anim_name):
	queue_free() # Replace with function body.
