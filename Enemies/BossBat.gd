# Must be child of PersistentObject
extends Node2D

const HeartContainer = preload("res://World/HeartContainer.tscn")

signal collected(Node2D)

export(int) var max_health = 5
onready var bat = $Bat

func _ready():
	bat.set_max_health(max_health)

func _on_Bat_no_health():
	drop_heart_container()
	emit_signal("collected", self)
	queue_free()

func drop_heart_container():
	var container = HeartContainer.instance()
	get_parent().add_child(container)
	container.global_position = bat.global_position
