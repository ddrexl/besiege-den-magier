extends HBoxContainer

func _ready():
	if GameProgress.touch_controls:
		show()
