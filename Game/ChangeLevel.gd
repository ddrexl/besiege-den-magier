extends Node

export(String, FILE, "*.tscn") var level
export (float) var fade_in_duration = 0.5 setget set_fade_in_duration

onready var fade_in = $CanvasLayer/Screen/FadeIn
onready var screen = $CanvasLayer/Screen

func change_level():
	screen.show()
	fade_in.fade_in(fade_in_duration)

func _on_FadeIn_fade_finished():
	get_tree().change_scene(level)

func set_fade_in_duration(value):
	fade_in_duration = clamp(value, 0.1, 10.0)
