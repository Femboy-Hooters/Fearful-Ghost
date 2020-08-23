extends Node

var position = 0.0

func play():
	$"Music".play(0.1)
func pause():
	position = $"Music".get_playback_position()
	$"Music".pause()
func load_stream(index):
	$"Music".stream = Global.soundFXs[index]
