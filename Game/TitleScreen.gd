extends Control

onready var menu_buttons = $Menu/CenterRow/VBoxContainer/Buttons
onready var start_button = $Menu/CenterRow/VBoxContainer/Buttons/StartButton
onready var change_level = $ChangeLevel

func _ready():
	OS.low_processor_usage_mode = OS.get_name() != "Android"
	start_button.grab_focus()
	for button in menu_buttons.get_children():
		button.connect("pressed", self, "_on_Button_selected", [button.scene_to_load])
		
func _on_Button_selected(scene_to_load):
	change_level.level = scene_to_load
	change_level.fade_in_duration = 0.5
	change_level.change_level()
