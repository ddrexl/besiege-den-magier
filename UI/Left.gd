extends Button

func _ready():
	if GameProgress.touch_controls:
		show()

func _pressed():
	Input.action_press("ui_left")
