extends Control

var s_color  = Color(0.0, 1.0, 0.0)
var ns_color = Color(1.0, 1.0, 1.0)

onready var container = $"VBoxContainer/VBoxContainer2"

func _ready():
	MusicStream.load_stream(1)
	MusicStream.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func tutorial():
	$"Timer".start()
	$"Tutorial".visible = true

func _on_start_button_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Global.first_time:
		Global.first_time = false
		$"Timer".start()
		$"Tutorial".visible = true
	else:
		get_tree().change_scene("res://scene/level.tscn")

func _on_settings_button_pressed():
	get_tree().change_scene("res://scene/settings_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_start_button_mouse_entered():
	container.get_child(0).modulate = s_color

func _on_start_button_mouse_exited():
	container.get_child(0).modulate = ns_color
	
func _on_settings_button_mouse_entered():
	container.get_child(1).modulate = s_color

func _on_settings_button_mouse_exited():
	container.get_child(1).modulate = ns_color

func _on_tutorial_button_mouse_entered():
	container.get_child(2).modulate = s_color

func _on_tutorial_button_mouse_exited():
	container.get_child(2).modulate = ns_color
	
func _on_quit_button_mouse_entered():
	container.get_child(3).modulate = s_color

func _on_quit_button_mouse_exited():
	container.get_child(3).modulate = ns_color
	
func _on_Timer_timeout():
	get_tree().reload_current_scene()

