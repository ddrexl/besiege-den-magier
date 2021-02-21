extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")
const Heart = preload("res://World/Heart.tscn")
onready var center = $Center

func create_grass_effect():
	var grass_effect = GrassEffect.instance()
	var world = get_tree().current_scene
	world.add_child(grass_effect)
	grass_effect.global_position = global_position


func _on_Hurtbox_area_entered(_area):
	create_grass_effect()
	maybe_drop_heart()
	queue_free()

func _on_FireHurtBox_fire_ended():
	maybe_drop_heart()
	queue_free()

func maybe_drop_heart():
	var drop = randi() % 4 == 0
	if drop:
		var heart = Heart.instance()
		heart.global_position = center.global_position
		get_parent().add_child(heart)
