extends Node2D

export(String, FILE, "*.tscn") var level
export(String) var player_location

onready var change_level = $ChangeLevel

func _ready():
	change_level.level = level
	change_level.fade_in_duration = 0.3

func _on_Area2D_body_entered(body):
	PlayerStats.spawn_location = player_location
	change_level.change_level()
