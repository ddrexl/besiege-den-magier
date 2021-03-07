extends AnimatedSprite

var stats = PlayerStats
onready var heart_sound = $HeartSound

func _on_Area2D_body_entered(_body):
	stats.health += 1
	heart_sound.play()
	queue_free()
