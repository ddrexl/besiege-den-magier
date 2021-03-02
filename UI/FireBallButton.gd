extends Button

func _ready():
	PlayerStats.connect("fire_ball_magic_obtained", self, "show")
	if PlayerStats.has_fire_ball_magic:
		show()

func _pressed():
	Input.action_press("fire_ball")
