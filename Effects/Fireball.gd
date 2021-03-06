extends KinematicBody2D

export(int) var SPEED = 200
export(int) var lifetime = 4
var direction = Vector2.DOWN

onready var timer = $Timer

func _ready():
	if lifetime > 0:
		timer.wait_time = lifetime
		timer.start()

func _physics_process(delta):
	var collision = move_and_collide(direction * SPEED * delta)
	if collision:
		SPEED = 0

func _on_Timer_timeout():
	queue_free()
