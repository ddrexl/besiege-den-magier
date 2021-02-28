extends Control

onready var back_button = $CenterContainer/VBoxContainer/Button
onready var change_level = $ChangeLevel

func _ready():
	back_button.grab_focus()

func _on_Button_pressed():
	PlayerStats.reset()
	GameProgress.reset()
	change_level.change_level()
