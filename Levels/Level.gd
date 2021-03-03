extends Node2D

onready var player = $Entities/Player
onready var spawn_location_node = $SpawnLocations
var spawn_locations = {}

func _ready():
	init_spawn_locations()
	spawn_player()

func init_spawn_locations():
	for l in spawn_location_node.get_children():
		spawn_locations[l.name] = {"position": l.position, "facing": l.get_facing_direction()}

func spawn_player():
	set_player_location()
	set_player_facing()

func set_player_location():
	var spawn_location = PlayerStats.spawn_location
	var location = Vector2.ZERO
	if spawn_location in spawn_locations:
		location = spawn_locations[spawn_location]["position"]
	else:
		location = player.global_position
	player.global_position = location

func set_player_facing():
	var spawn_location = PlayerStats.spawn_location
	var facing_direction = Vector2.DOWN
	if spawn_location in spawn_locations:
		facing_direction = spawn_locations.get(spawn_location)["facing"]
	player.face_in_direction(facing_direction)
