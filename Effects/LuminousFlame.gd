extends Node2D

onready var light = $Light2D

func _ready():
	light.energy = GameProgress.fire_brightness
