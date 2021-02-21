extends AnimatedSprite

var stats = PlayerStats
var heart_sound = preload("res://Audio/Heart.wav")

func _on_Area2D_body_entered(body):
	stats.health += 1
	play_heart_sound()
	queue_free()

func play_heart_sound():
	var player = AudioStreamPlayer.new()
	player.stream = heart_sound
	player.volume_db = 15
	player.connect("finished", player, "queue_free")
	get_parent().add_child(player)
	player.play()
