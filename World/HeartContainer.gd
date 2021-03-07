extends AnimatedSprite

var stats = PlayerStats
onready var heart_sound = $HeartSound

signal collected(Node2D)

func _on_Area2D_body_entered(_body):
	stats.max_health += 1
	stats.health = stats.max_health
	heart_sound.play()
	emit_signal("collected", self)
	queue_free()
