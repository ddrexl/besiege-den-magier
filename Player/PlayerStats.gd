extends Node

enum SpawnFacing {
	UP,
	DOWN,
	LEFT,
	RIGHT
} 

export(int) var max_health = 1 setget set_max_health
var health = max_health setget set_health
var coins = 0 setget set_coins
var spawn_location = "start"
var spawn_facing = SpawnFacing.DOWN


signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal coins_changed(value)

func set_health(value):
	health = min(value, max_health)
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_coins(value):
	coins = value
	emit_signal("coins_changed", value)

func _ready():
	self.health = max_health
	self.max_health = max_health

