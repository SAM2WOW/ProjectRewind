extends Node

# Define sushi types
enum S_TYPE {NIGIRI, ROLL}

# Define ingredients
enum INGREDIENT {SALMON, SHRIMP, CUCUMBER, RADISH, RICE, SEAWEED}

# Only allow clicking one thing
var mouse_selected = false

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
			return "res://Arts/Sushi/shrimp.png"
		INGREDIENT.RADISH:
			return "res://Arts/Sushi/shrimp.png"
		INGREDIENT.RICE:
			return "res://Arts/Sushi/shrimp.png"
		INGREDIENT.SEAWEED:
			return "res://Arts/Sushi/PHseaweed.jpg"
