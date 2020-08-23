extends Area

onready var player = get_parent().get_node("player")
onready var timer = get_parent().get_node("teleport_timer")

func _ready():
	timer.set_wait_time(2)

func _on_teleport_1_body_entered(body):
	if not timer.get_time_left():
		teleport(get_parent().get_node("teleport_2"),body)
		timer.start()

func _on_teleport_2_body_entered(body):
	if not timer.get_time_left():
		teleport(get_parent().get_node("teleport_1"),body)
		timer.start()

func teleport(node,body):
	$"FxPlayer".play_SFX(0)
	body.teleport(node.translation)
	
func TimerTimeout():
	timer.stop()
