extends Area2D


var ingredient = Global.INGREDIENT.RICE
var statu = 1

func dropped():
	Global.Console.addPoint(0.1)
	
	$AnimationPlayer.play("drop")


func _on_RiceBox_area_entered(area):
	if "Rice" in area.name:
		$AnimationPlayer.play("drop")
