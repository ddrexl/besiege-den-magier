extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

export(float) var invincibility_duration = 0.1
var invincible = false setget set_invincible

onready var invincibility_cooldown = $InvincibilityCooldown
onready var collision_shape = $CollisionShape2D

signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value # does not call the setter without self (no recursion)
	if invincible == true:
		collision_shape.set_deferred("disabled", true)
		emit_signal("invincibility_started")
	else:
		collision_shape.disabled = false
		emit_signal("invincibility_ended")

func start_invincibility():
	self.invincible = true # calls the setter on self
	invincibility_cooldown.start(invincibility_duration)
	
func create_hit_effect():	
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func _on_InvincibilityCooldown_timeout():
	self.invincible = false # calls the setter on self
