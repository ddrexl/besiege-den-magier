extends GridContainer


func _ready():
	if GameProgress.touch_controls:
		show()
