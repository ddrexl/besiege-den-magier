extends Control

onready var menu_options = $Menu/CenterRow/VBoxContainer/Options

func _ready():
	for option in menu_options.get_children():
		option.connect("pressed", self, "_on_Option_selected", [option.scene_to_load])
		

func _on_Option_selected(scene_to_load):
	get_tree().change_scene(scene_to_load)
