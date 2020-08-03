extends Node2D


var hand_open = preload("res://Arts/PHgand_open.png")
var hand_close = preload("res://Arts/PHhand_close.png")


func _ready():
	# Hide mouse while in game
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(delta):
	# Follow mouse
	set_global_position(get_global_mouse_position())


func _input(event):
	# Change sprites
	if Input.is_action_just_pressed("touch"):
		
		$Sprite.set_texture(hand_close)
		$Sprite.set_modulate(Color("37ffffff"))
		
	elif Input.is_action_just_released("touch"):
		
		$Sprite.set_texture(hand_open)
		$Sprite.set_modulate(Color("d6ffffff"))
