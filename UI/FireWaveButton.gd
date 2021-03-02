extends Button

func _ready():
	PlayerStats.connect("fire_wave_magic_obtained", self, "show")
	if PlayerStats.has_fire_wave_magic:
		show()

func _pressed():
	Input.action_press("fire_wave")
