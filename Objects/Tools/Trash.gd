extends Area2D


func _ready():
	pass


func dropped(ingredient):
	$Fake_Sushi.set_texture(load(Global.ingredient_to_address(ingredient)))
	
	$AnimationPlayer.play("trashed")
	
