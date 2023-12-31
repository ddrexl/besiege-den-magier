extends Area2D

func is_colliding():
	return get_overlapping_areas().size() > 0
	
func get_push_vector():
	var push_vector = Vector2.ZERO
	var area = get_overlapping_areas()[0]
	push_vector = area.global_position.direction_to(global_position)
	push_vector = push_vector.normalized()
	return push_vector

func apply(velocity, delta):
	if is_colliding():
		velocity += get_push_vector() * delta * 400
	return velocity
