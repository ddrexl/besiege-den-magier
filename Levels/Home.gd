extends Node2D

const A = Vector2(280, 144)
const WEST = Vector2(24, 304)

#func _input(event):
#	if event.is_action_pressed("ui_accept"):
#		var Bat = load("res://Enemies/Bat.tscn")
#		var bat = Bat.instance()
#		bat.global_position = Vector2(200, 220)
#		$YSort.add_child(bat)
#	if event.is_action_pressed("ui_cancel"):
#		PlayerStats.health += 1
