extends "res://Scripts/DraggableArea2D.gd"

signal on_dropped

# Decide what ingredient this is
export (Global.INGREDIENT) var ingredient = Global.INGREDIENT.SALMON

var droppable = false

var on_cutting_board = false

# Reference for the dropped box
var box_ref
var board_ref

func _ready():
	change_ingredient()

func change_ingredient():
	$Sprite.set_texture(load(Global.ingredient_to_address(ingredient)))


func _process(delta):
	if Global.Console.frenzy_mode:
		var new_volume = clamp(Global.Console.get_parent().volume * 0.2 + 1, 1, 1.5)
		$Sprite.scale = lerp($Sprite.scale, Vector2(new_volume, new_volume), delta * 20)


func _on_Sushi_Piece_on_dragging():
	# Set random rotation
	set_rotation_degrees(rand_range(-20, 20))
	
	$AnimationPlayer.play("pick_up")
	
	$Grab.play()
	
	Global.current_holding.append(self)


# Drop and kill the ingredient 
func _on_Sushi_Piece_on_released():
	if Global.check_dropping:
		return
	
	Global.current_holding.erase(self)
	
	# If drop on the trash
	if droppable and "Trash" in box_ref.name:
		box_ref.dropped(ingredient)
		emit_signal("on_dropped")
		queue_free()
	
	if droppable and "RiceBox" in box_ref.name:
		box_ref.dropped()
		emit_signal("on_dropped")
		queue_free()
	
	# I moved this detection to drop box
	#elif droppable and box_ref.ingredient == ingredient and box_ref.statu == 0:
	#	box_ref.dropped()
	#	emit_signal("on_dropped")
	#	queue_free()
	
	# If drop on cutting board
	if on_cutting_board:
		
		$RayCast2D.enabled = true
		$RayCast2D.cast_to = to_local(board_ref.get_global_position())
		$RayCast2D.force_raycast_update()

		if $RayCast2D.is_colliding():
			
			set_original_position(get_parent().to_local($RayCast2D.get_collision_point()))
		else:
			set_original_position(get_position())
			
		$RayCast2D.enabled = false
		$AnimationPlayer.play("drop")
	
	$Drop.play()


# Check if the box is the right box
# Set droppable to true if it is the right box
func _on_Sushi_Piece_area_entered(area):
	if "Box" in area.name:
		box_ref = area
		
		# Only allow dropping on correct ingredient box
		if area.ingredient == ingredient:
			droppable = true
	
	if "Drop" in area.name:
		droppable = true
	
	elif "Trash" in area.name:
		box_ref = area
		droppable = true
	
	elif "Cutting_Board" in area.name:
		on_cutting_board = true
		board_ref = area
	
	# Scrap the rice if scrappable
	elif "Scrap" in area.name and ingredient == Global.INGREDIENT.RICE:
		if area.get_parent().enabled:
			$CollisionShape2D.call_deferred("set_disabled", true)
			
			$Tween.interpolate_property(self, "global_position",
				get_global_position(), Global.rice_box_pos, 0.2,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			
			$ScrapRice.play()
			
			#Global.Console.addPoint(0.1)
			Global.rice_box.dropped()


func _on_Sushi_Piece_area_exited(area):
	if "Drop" in area.name:
		#if area.ingredient == ingredient:
		droppable = false
	
	if "Trash" in area.name:
		droppable = false
	
	elif "Cutting_Board" in area.name:
		on_cutting_board = false


func _on_Tween_tween_all_completed():
	Global.current_holding.erase(self)
	queue_free()
