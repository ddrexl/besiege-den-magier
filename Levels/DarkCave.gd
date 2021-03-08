extends Level

var old_value = GameProgress.fire_brightness
const cave_value = 0.8

func _enter_tree():
	# need brighter fire in here
	GameProgress.fire_brightness = cave_value

func _exit_tree():
	GameProgress.fire_brightness = old_value
