extends Control


onready var menu_buttons = $Menu/CenterRow/VBoxContainer/Buttons
onready var start_button = $Menu/CenterRow/VBoxContainer/Buttons/StartButton
onready var fade_in = $FadeIn
var scene_path_to_load

func _ready():
	start_button.grab_focus()
	for button in menu_buttons.get_children():
		button.connect("pressed", self, "_on_Button_selected", [button.scene_to_load])
		

func _on_Button_selected(scene_to_load):
	scene_path_to_load = scene_to_load
	fade_in.show()
	fade_in.fade_in()


func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)
