extends Node

# Define sushi types
enum S_TYPE {NIGIRI, ROLL}

# Define ingredients
enum INGREDIENT {SALMON, SHRIMP, CUCUMBER, RADISH, RICE, SEAWEED}

# Only allow clicking one thing
var mouse_selected = false

var Console = null
