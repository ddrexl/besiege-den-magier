extends ColorRect

signal fade_finished
onready var player = $AnimationPlayer

func fade_in(duration=0.5):
	player.playback_speed = 1/duration
	player.play("fade_in")

func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("fade_finished")
