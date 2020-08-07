extends AudioStreamPlayer2D


export var base_volume = 0.0


# Set the audio volume and pitch to random in range
func _ready():
	connect("finished", self, "_on_finished")
	reset_parameter()


func _on_finished():
	reset_parameter()


func reset_parameter():
	randomize()
	set_volume_db(base_volume + rand_range(-5, 0))
	set_pitch_scale(rand_range(0.9, 1))
