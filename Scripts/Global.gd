extends Node

# Define sushi types
enum S_TYPE {NIGIRI, ROLL}

# Define ingredients
enum INGREDIENT {SALMON, SHRIMP, CUCUMBER, RADISH, RICE, SEAWEED}

# Only allow clicking one thing
var mouse_selected = false

# Rice box position for rice doing the animation
var rice_box_pos = Vector2(1649.43, 427.442)

# Console Reference
var Console = null

# Check if seen tutorial
var tutorial_seen = false

# Game Version
var game_version = "1.2.0"

func _ready():
	# Load the slientwolf plugins
	SilentWolf.configure({
		"api_key": "2miuqSdUCS15IuAR2w1JW1nhosvRbg7e9jCzDefb",
		"game_id": "SUSHIunROLL",
		"game_version": game_version,
		"log_level": 0
	})

	SilentWolf.configure_scores({
		"open_scene_on_close": "res://Maps/Main.tscn"
	})


# Return ingredient address
func ingredient_to_address(i):
	match i:
		INGREDIENT.SALMON:
			return "res://Arts/Sushi/salmon.png"
		INGREDIENT.SHRIMP:
			return "res://Arts/Sushi/shrimp.png"
		INGREDIENT.CUCUMBER:
			return "res://Arts/Sushi/zucchini.png"
		INGREDIENT.RADISH:
			return "res://Arts/Sushi/yellow_radish.png"
		INGREDIENT.RICE:
			return "res://Arts/Sushi/nigiri_rice.png"
		INGREDIENT.SEAWEED:
			return "res://Arts/Sushi/whole_sushi_roll_held.png"


func ingredient_to_colors(i):
	match i:
		INGREDIENT.SALMON:
			return Color("f25738")
		INGREDIENT.SHRIMP:
			return Color("f28b38")
		INGREDIENT.CUCUMBER:
			return Color("93a603")
		INGREDIENT.RADISH:
			return Color("f2c744")
		INGREDIENT.SEAWEED:
			return Color("4a4b31")


func ingredient_to_icons(i):
	match i:
		INGREDIENT.SALMON:
			return "res://Arts/Font/salmon_outline.png"
		INGREDIENT.SHRIMP:
			return "res://Arts/Font/shrimp_outline.png"
		INGREDIENT.CUCUMBER:
			return "res://Arts/Font/cucumber_outline.png"
		INGREDIENT.RADISH:
			return "res://Arts/Font/radish_outline.png"
		INGREDIENT.SEAWEED:
			return "res://Arts/Font/seaweed_outline.png"


# Used for reparenting nodes
func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
