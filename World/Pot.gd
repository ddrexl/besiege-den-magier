extends StaticBody2D

const PotShatterEffect = preload("res://Effects/PotShatterEffect.tscn")
onready var item_drop = $ItemDrop
signal collected(Node2D)

func create_pot_shatter_effect():
	var pot_shatter_effect = PotShatterEffect.instance()
	var world = get_tree().current_scene
	world.add_child(pot_shatter_effect)
	pot_shatter_effect.global_position = global_position

func _on_Hurtbox_area_entered(_area):
	create_pot_shatter_effect()
	item_drop.drop_item()
	emit_signal("collected", self)
	queue_free()
