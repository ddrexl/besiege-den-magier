extends Control

var coins = 0 setget set_coins

onready var label = $Label

func set_coins(value):
	coins = clamp(value, 0, 9999)
	label.text = str(coins)

func _ready():
	self.coins = PlayerStats.coins
	PlayerStats.connect("coins_changed", self, "set_coins")
