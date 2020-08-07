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


# Used for reparenting nodes
func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
