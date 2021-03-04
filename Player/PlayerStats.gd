extends Node

const initial_max_health = 3

export(int) var max_health = initial_max_health setget set_max_health
var health = max_health setget set_health
var coins = 0 setget set_coins
var spawn_location = ""
var has_sword = true setget set_has_sword
var has_fire_ball_magic = true setget set_has_fire_ball_magic
var has_fire_wave_magic = true setget set_has_fire_wave_magic

signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal coins_changed(value)
signal sword_obtained
signal fire_ball_magic_obtained
signal fire_wave_magic_obtained

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

func set_has_sword(value):
	has_sword = value
	if has_sword:
		emit_signal("sword_obtained")
		
func set_has_fire_ball_magic(value):
	has_fire_ball_magic = value
	if has_fire_ball_magic:
		emit_signal("fire_ball_magic_obtained")

func set_has_fire_wave_magic(value):
	has_fire_wave_magic = value
	if has_fire_wave_magic:
		emit_signal("fire_wave_magic_obtained")

func _ready():
	self.health = max_health
	self.max_health = max_health

func reset():
	self.max_health = initial_max_health
	self.health = initial_max_health
	self.coins = 0
	self.spawn_location = ""
	self.has_sword = false
	self.has_fire_ball_magic = false
	self.has_fire_wave_magic = false
