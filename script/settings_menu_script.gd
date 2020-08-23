extends Control

onready var VolumeValue = $"VBoxContainer/Volume/VolumeSlider"
onready var FovValue = $"VBoxContainer/Fov/FovSlider"
onready var SensValue = $"VBoxContainer/Sensibility/SensSlider"
onready var VolumeText = $"VBoxContainer/Volume/Number"
onready var FovText = $"VBoxContainer/Fov/Number"
onready var SensText = $"VBoxContainer/Sensibility/Number"

func _ready():
	VolumeValue.value = Global.volume
	FovValue.value = Global.fov
	SensValue.value = Global.sensibility

func _on_back_button_pressed():
	Global.volume = int(VolumeValue.value)
	Global.fov = int(FovValue.value)
	Global.save_data([FovValue.value,VolumeValue.value], "settings")
	get_tree().change_scene("res://scene/menu.tscn")

func _on_VolumeSlider_value_changed(value):
	VolumeText.text = String(value)
	value = Global.log_base(10, value/100)*36
	print(value)
	AudioServer.set_bus_volume_db(0, value)

func _on_FovSlider_value_changed(value):
	FovText.text = String(value)

func _on_SensSlider_value_changed(value):
	SensText.text = String(value*100)

