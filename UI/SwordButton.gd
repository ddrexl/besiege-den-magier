extends TextureButton

func _ready():
	PlayerStats.connect("sword_obtained", self, "show")

func _pressed():
	Input.action_press("attack")
