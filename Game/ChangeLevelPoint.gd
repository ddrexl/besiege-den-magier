extends Node2D

export(String, FILE, "*.tscn") var level
export(String) var player_location
export(PlayerStats.SpawnFacing) var player_face_direction = PlayerStats.SpawnFacing.UP

onready var change_level = $ChangeLevel

func _ready():
	change_level.level = level
	change_level.fade_in_duration = 0.3

func _on_Area2D_body_entered(body):
	PlayerStats.spawn_location = player_location
	PlayerStats.spawn_facing = player_face_direction
	change_level.change_level()
