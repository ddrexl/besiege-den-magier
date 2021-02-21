extends Node2D

export(int) var wander_range = 32

onready var start_position = global_position
onready var target_position = global_position

func update_target_position():
	var rand_x = rand_range(-wander_range, wander_range)
	var rand_y = rand_range(-wander_range, wander_range)
	
	var target_vector = Vector2(rand_x, rand_y)
	target_position = start_position + target_vector

		
func has_arrived_at_target_position(position_):
	return position_.distance_to(target_position) <= 4

func start_wander_timer(duration):
	$Timer.start(duration)
	
func _on_Timer_timeout():
	update_target_position()
	start_wander_timer(rand_range(1,3))
