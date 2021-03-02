extends HBoxContainer

func _ready():
	if GameProgress.show_combat_controls:
		show()
