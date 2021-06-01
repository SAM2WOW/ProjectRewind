extends Node2D

const hand_colors = ["ffffff", "efd0a3", "a58557"]

var hand_open = preload("res://Arts/open_hand.png")
var hand_close = preload("res://Arts/closed_hand.png")

var touch_screen = false


func _ready():
	# Check if device is touch supported
	if OS.has_touchscreen_ui_hint():
		touch_screen = true
		
		$Sprite.hide()
		$Sprite.set_texture(hand_close)
		$Sprite.set_modulate(Color("bdffffff"))
		
	else:
		# Hide mouse while in game
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# Random skin tone
	#randomize()
	#$Sprite.set_self_modulate(Color(hand_colors[randi() % 3]))


func _process(_delta):
	# Follow mouse
	set_global_position(get_global_mouse_position())


func _input(event):
	if touch_screen:
		if event is InputEventScreenTouch:
			$Sprite.set_visible(event.pressed)
	
	# Change sprites
	if Input.is_action_just_pressed("touch"):
		
		$Sprite.set_texture(hand_close)
		$Sprite.set_modulate(Color("bdffffff"))
		
	elif Input.is_action_just_released("touch"):
		
		$Sprite.set_texture(hand_open)
		$Sprite.set_modulate(Color("ffffff"))
