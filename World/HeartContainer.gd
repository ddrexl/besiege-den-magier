extends AnimatedSprite

var stats = PlayerStats
var heart_sound = preload("res://Audio/Heart.wav")

signal collected(Node2D)

func _on_Area2D_body_entered(_body):
	stats.max_health += 1
	stats.health = stats.max_health
	play_heart_sound()
	emit_signal("collected", self)
	queue_free()

func play_heart_sound():
	var player = AudioStreamPlayer.new()
	player.stream = heart_sound
	player.volume_db = 15
	player.connect("finished", player, "queue_free")
	get_parent().add_child(player)
	player.play()
