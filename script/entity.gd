extends KinematicBody

var speed = 3
var index = 0
var heart = 0

onready var pos = Vector3.ZERO
onready var points = []
onready var timer = $"Timer"
onready var animation = $"Pirate/AnimationPlayer"
onready var mesh = $"Pirate/Armature/Skeleton/Body_LOD001"


func _ready():
	timer.set_wait_time(20)
	timer.start()

func travel():
	var obiettivo = get_parent().get_node("player").transform.origin
	obiettivo = transform.origin - obiettivo
	obiettivo += transform.origin
	points = Array(get_parent().get_node("Navigation").get_simple_path(global_transform.origin, obiettivo))
	index = 0
	animation.play("walk")

func _physics_process(delta):
	var distance = transform.origin.distance_to(get_parent().get_node("player").transform.origin)
	if distance < 30:
		if distance < 5:
			heart = 0
			$"Sprite3D".set_frame(heart)
		if index < points.size():
			var move_vec = (points[index] - global_transform.origin)
			if abs(move_vec.length()) < 0.5:
				index += 1
				if index < points.size():
					mesh.look_at(points[index],Vector3.UP)
					mesh.rotation_degrees.y += 180
					mesh.rotation_degrees.x = 0
					mesh.rotation_degrees.z = 0
			else:
				move_and_slide(move_vec.normalized() * speed, Vector3(0, 1, 0))
		else:
			travel()
	elif animation.current_animation == "walk":
		animation.play("default")

func teleport(target):
	points = []
	target.y = 0
	translation = target
	print("teleport")

func update_heart():
	heart += 1
	if heart == 4:
		get_tree().change_scene("res://scene/gameover_scene.tscn")
	$"Sprite3D".set_frame(heart)
