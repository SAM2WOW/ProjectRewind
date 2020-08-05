extends AudioStreamPlayer2D


# Set the audio volume and pitch to random in range
func _ready():
	connect("finished", self, "_on_finished")
	reset_parameter()


func _on_finished():
	reset_parameter()


func reset_parameter():
	randomize()
	set_volume_db(rand_range(-5, 0))
	set_pitch_scale(rand_range(0.9, 1))
