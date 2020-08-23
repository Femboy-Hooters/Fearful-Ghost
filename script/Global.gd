extends Node

var first_time = true
var fov = 80
var volume = 100
var sensibility = 0.1
var soundFXs = []
#const resolutions = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var settings = load_data("settings")
	if settings:
		fov = int(settings[0])
		volume = int(settings[1])
		sensibility = float(settings[2])
		first_time = false
	else:
		save_data([fov, volume, sensibility], "settings")
	load_sounds("sounds")
	AudioServer.set_bus_volume_db(0, log_base(10, Global.volume/100)*36)

func load_data(filename : String):
	var file = File.new()
	var path = "res://Data/"+filename+".fragola"
	if !file.open(path, File.READ):
		var data = []
		while !file.eof_reached():
			data.append(file.get_line())
		file.close()
		return data
	return false

func save_data(data : Array, filename : String):
	var file = File.new()
	var path = "res://Data/"+filename+".fragola"
	if !file.open(path, File.WRITE):
		for element in data:
			file.store_line(String(element))
		file.close()
		return true
	return false

func load_sounds(path_to_list : String):
	for path in load_data(path_to_list):
		soundFXs.append(load(path))

func log_base(base: float, value: float):
	return log(value)/log(base)
