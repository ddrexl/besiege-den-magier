extends Area2D

const BurnEffect = preload("res://Effects/BurnEffect.tscn")

export(int) var DAMAGE_PER_SECOND = 1

onready var collision_shape = $CollisionShape2D
onready var burning_timer = $BurningTimer
onready var damage_timer = $DamageTimer

signal fire_ended
signal deal_fire_damage

func _on_FireHurtBox_area_entered(_area):
	create_burn_effect()
	start_fire()
	
func create_burn_effect():
	var effect = BurnEffect.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position

func start_fire():
	collision_shape.set_deferred("disabled", true)
	burning_timer.start()
	damage_timer.start()
	
func end_fire():
	collision_shape.set_deferred("disabled", false)
	damage_timer.stop()
	emit_signal("fire_ended")

func _on_BurningTimer_timeout():
	end_fire()

func _on_DamageTimer_timeout():
	damage_timer.start()
	emit_signal("deal_fire_damage", DAMAGE_PER_SECOND)
