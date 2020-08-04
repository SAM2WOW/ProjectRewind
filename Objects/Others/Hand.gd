extends Node2D


var hand_open = preload("res://Arts/open_hand.png")
var hand_close = preload("res://Arts/closed_hand.png")


func _ready():
	# Hide mouse while in game
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(_delta):
	# Follow mouse
	set_global_position(get_global_mouse_position())


func _input(_event):
	# Change sprites
	if Input.is_action_just_pressed("touch"):
		
		$Sprite.set_texture(hand_close)
		$Sprite.set_modulate(Color("bdffffff"))
		
	elif Input.is_action_just_released("touch"):
		
		$Sprite.set_texture(hand_open)
		$Sprite.set_modulate(Color("ffffff"))
