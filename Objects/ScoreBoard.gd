extends Label


var charge = 0
var note = preload("res://Objects/Others/FloatingLabel.tscn")

onready var charge_node = get_node("../MarginContainer/Charge")


func changePoint(point,_sign):
	if _sign ==1:
		charge += point
		charge_node.set_text("-"+str(charge*100))
	else:
		charge -= point
		charge_node.set_text("-"+str(charge*100))
	$Timer.start()


func _on_Timer_timeout():
	charge_node.set_text("")
	var noter = note.instance()
	noter.value = charge
	add_child(noter)
	self.set_text(str($"../../..".money * 100) + "¥")
	charge = 0 
