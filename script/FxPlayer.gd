extends AudioStreamPlayer3D

func play_SFX(index : int):
	stream = Global.soundFXs[index]
	play()
