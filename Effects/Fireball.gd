extends KinematicBody2D

export(int) var SPEED = 200
var direction = Vector2.DOWN

func _physics_process(delta):
	var collision = move_and_collide(direction * SPEED * delta)
	if collision:
		SPEED = 0

func _on_Timer_timeout():
	queue_free()
