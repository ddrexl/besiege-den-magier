extends Node2D

var Heart = preload("res://World/Heart.tscn")
var Coin = preload("res://World/Coin.tscn")

export (int) var chance_nothing = 1 setget set_chance_nothing
export (int) var chance_heart = 0 setget set_chance_heart
export (int) var chance_coin = 0 setget set_chance_coin

func set_chance_nothing(value):
	chance_nothing = clamp(value, 1, 100)

func set_chance_heart(value):
	chance_heart = clamp(value, 0, 100)

func set_chance_coin(value):
	chance_coin = clamp(value, 0, 100)

func drop_item():
	var sum = float(chance_nothing + chance_heart + chance_coin)
	var rand = randf()
	var a = chance_nothing / sum
	var b = a + (chance_heart / sum)
	var c = b + (chance_coin / sum)
	
	print("rand", rand)
	
	if rand <= a:
		drop_nothing()
	elif rand <= b:
		drop_heart()
	elif rand <= c:
		drop_coin()

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
