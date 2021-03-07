extends StaticBody2D

var stats = PlayerStats
onready var heal = $HealBox
onready var timer = $Timer
onready var heart_sound = $HeartSound

func _on_Timer_timeout():
	if stats.health < stats.max_health:
		PlayerStats.health += 1
		heart_sound.play()
	timer.start()


func _on_HealBox_body_entered(player):
	timer.start()
	player.blink_animation.play("start")


func _on_HealBox_body_exited(player):
	timer.stop()
	player.blink_animation.play("stop")
