extends TextureButton

func _ready():
	PlayerStats.connect("sword_obtained", self, "show")
	if PlayerStats.has_sword:
		show()

func _pressed():
	Input.action_press("attack")
