extends ColorRect

signal fade_finished

onready var player = $AnimationPlayer

func fade_in(custom_speed=1.0):
	player.play("fade_in", -1, custom_speed)


func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("fade_finished")
