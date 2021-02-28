extends Area2D

export(String, FILE, "*.tscn") var level
export(String) var player_location
export(PlayerStats.SpawnFacing) var player_face_direction = PlayerStats.SpawnFacing.UP

onready var fade_in = $CanvasLayer/Screen/FadeIn

func _on_ChangeLevel_body_entered(_body):
	PlayerStats.spawn_location = player_location
	PlayerStats.spawn_facing = player_face_direction
	fade_in.show()
	fade_in.fade_in(1.5) # default is 0.5s, we make it 50% faster

func _on_FadeIn_fade_finished():
	get_tree().change_scene(level)
