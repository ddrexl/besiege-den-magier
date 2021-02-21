extends Node2D

var Heart = preload("res://World/Heart.tscn")
var Coin = preload("res://World/Coin.tscn")

func drop_item():
	match randi() % 3:
		0: drop_nothing()
		1: drop_heart()
		2: drop_coin()

func drop_nothing():
	pass
	
func drop_heart():
	var heart = Heart.instance()
	heart.global_position = global_position
	get_parent().get_parent().add_child(heart) # ysort

func drop_coin():
	var coin = Coin.instance()
	coin.global_position = global_position
	get_parent().get_parent().add_child(coin) # ysort
