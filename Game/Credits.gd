extends Control

onready var back_button = $CenterContainer/VBoxContainer/Button

func _ready():
	back_button.grab_focus()

func _on_Button_pressed():
	get_tree().change_scene("res://Game/TitleScreen.tscn")
