extends Position2D

enum SpawnFacing {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

export (SpawnFacing) var spawn_facing = SpawnFacing.DOWN

func get_facing_direction():
	var direction = Vector2.DOWN
	match spawn_facing:
		SpawnFacing.UP:
			direction = Vector2.UP
		SpawnFacing.DOWN:
			direction = Vector2.DOWN
		SpawnFacing.LEFT:
			direction = Vector2.LEFT
		SpawnFacing.RIGHT:
			direction = Vector2.RIGHT
	return direction
