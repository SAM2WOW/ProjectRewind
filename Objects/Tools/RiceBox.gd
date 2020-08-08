extends Area2D


var ingredient = Global.INGREDIENT.RICE
var statu = 0

func dropped():
	Global.Console.addPoint(0.1)
	
	$AnimationPlayer.play("drop")
	
	$Particles2D.set_emitting(true)


func _on_RiceBox_area_entered(area):
	if "Rice" in area.name:
		$AnimationPlayer.play("drop")
		
		$Particles2D.set_emitting(true)
