extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var is_mouse_hover: bool  = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(_event):
	# Turn on dragging when mouse clicked on the area
	if is_mouse_hover and Input.is_action_just_pressed("touch"):
		$Box1.output()
		$Box2.output()
		$Box3.output()

func _on_AreaBox_mouse_entered():
	is_mouse_hover = true # Replace with function body.


func _on_AreaBox_mouse_exited():
	is_mouse_hover = false # Replace with function body.