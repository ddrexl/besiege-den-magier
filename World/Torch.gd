extends StaticBody2D

export(bool) var burning = false
onready var flame = $LuminousFlame

func _ready():
	if burning:
		flame.show()
	
func _on_FireHurtBox_fire_started():
	flame.show()
