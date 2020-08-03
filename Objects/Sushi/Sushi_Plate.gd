extends Node2D


const COLORS_LIST = ["e23d3d", "e29e3d", "e23dd4", "5ce04a", "4ac0e0", "e2e2e2"]

const SPEED = -300

var is_sushi_dragging = false


func _ready():
	# Random plate colors
	$Plate.set_modulate(Color(COLORS_LIST[randi() % 6]))


func _process(delta):
	# Move the plate
	if is_sushi_dragging == false:
		position += Vector2(SPEED * delta, 0)
		
	# Delete plate if out of screen
	if global_position.x <= -155:
		queue_free()


func _on_Sushi_on_dragging():
	is_sushi_dragging = true
	
	$Plate.set_self_modulate(Color("70ffffff"))


func _on_Sushi_on_released():
	is_sushi_dragging = false
	
	$Plate.set_self_modulate(Color("ffffff"))
