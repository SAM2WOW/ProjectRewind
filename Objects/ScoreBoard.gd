extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var charge = 0
var note = preload("res://Objects/Others/FloatingLabel.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func changePoint(point,_sign):
	if _sign ==1:
		charge += point
		$change.set_text("+"+str(charge*100))
	else:
		charge -= point
		$change.set_text("-"+str(charge*100))
	$Timer.start()


func _on_Timer_timeout():
	$change.set_text("")
	var noter = note.instance()
	noter.value = charge
	add_child(noter)
	self.set_text(str(get_parent().money*100))
	charge = 0 
