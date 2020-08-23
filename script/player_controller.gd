extends KinematicBody

var movement = Vector3.ZERO
const speed = 10
var mouse_sens = 0.1
var mouse_rotation = Vector2.ZERO
var sound_queue = []

onready var camera = $"Camera"
onready var player = $"FxPlayer"
onready var camera2 = $"ViewportContainer/Viewport/Camera2"

func _ready():
	camera.fov = Global.fov
	camera2.fov = Global.fov
	$"Camera".make_current()

func _physics_process(delta):
	movement = Vector3.ZERO
	if Input.is_action_pressed("move_forewards"):
		movement.z = -1
	if Input.is_action_pressed("move_backwards"):
		movement.z = +1
	if Input.is_action_pressed("move_left"):
		movement.x = -1
	if Input.is_action_pressed("move_right"):
		movement.x = +1
	if Input.is_action_pressed("stop"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene("res://scene/menu.tscn")
	movement = movement.normalized() 
	rotation_degrees.y -= mouse_rotation.x
	camera.rotation_degrees.x -= mouse_rotation.y
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)
	movement = movement.rotated(Vector3(0, 1, 0), rotation.y)
	move_and_slide(movement * speed)
	mouse_rotation = Vector2.ZERO
	camera2.global_transform = camera.global_transform
	
func _input(event):
	if event is InputEventMouseMotion:
		mouse_rotation.y = event.relative.y * mouse_sens
		mouse_rotation.x = event.relative.x * mouse_sens

func teleport(target):
	target.y = 0
	translation = target
	print("teleport")
