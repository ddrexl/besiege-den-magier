extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")
const Heart = preload("res://World/Heart.tscn")
onready var center = $Center
onready var item_drop = $ItemDrop

func create_grass_effect():
	var grass_effect = GrassEffect.instance()
	var world = get_tree().current_scene
	world.add_child(grass_effect)
	grass_effect.global_position = global_position


func _on_Hurtbox_area_entered(_area):
	create_grass_effect()
	item_drop.drop_item()
	queue_free()

func _on_FireHurtBox_fire_ended():
	item_drop.drop_item()
	queue_free()
