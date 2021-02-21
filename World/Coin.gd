extends AnimatedSprite

var stats = PlayerStats
var coin_sound = preload("res://Audio/Coin.wav")

func _on_Area2D_body_entered(_body):
	stats.coins += 1
	play_coin_sound()
	queue_free()

func play_coin_sound():
	var player = AudioStreamPlayer.new()
	player.stream = coin_sound
	player.connect("finished", player, "queue_free")
	get_parent().add_child(player)
	player.play()
