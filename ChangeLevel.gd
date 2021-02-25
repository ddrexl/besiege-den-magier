extends Area2D

export(String, FILE, "*.tscn") var level
export(String) var player_location
export(PlayerStats.SpawnFacing) var player_face_direction = PlayerStats.SpawnFacing.UP

func _on_ChangeLevel_body_entered(_body):
	PlayerStats.spawn_location = player_location
	PlayerStats.spawn_facing = player_face_direction
	get_tree().change_scene(level)
