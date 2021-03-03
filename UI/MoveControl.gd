extends Area2D

onready var shape = $CollisionShape2D

func _process(delta):
	if GameProgress.touch_controls:
		if Input.is_action_pressed("click"):
			action_press_direction()

		if Input.is_action_just_released("click"):
			action_release_all()
				
func action_press_direction():
	var center = global_position
	var radius = shape.shape.radius
	var mouse = get_global_mouse_position()
		
	if center.distance_to(mouse) > radius:
		return
	
	var angle = center.angle_to_point(mouse)
	
	if abs(angle) < 0.25 * PI:
		action_release_all()
		Input.action_press("ui_left")
	elif abs(angle) > 0.75 * PI:
		action_release_all()		
		Input.action_press("ui_right")
		
	if 0.25 * PI < angle and angle < 0.75 * PI:
		action_release_all()
		Input.action_press("ui_up")
	elif -0.25 * PI > angle and angle > -0.75 * PI:
		action_release_all()
		Input.action_press("ui_down")

func action_release_all():
	Input.action_release("ui_up")
	Input.action_release("ui_down")
	Input.action_release("ui_left")
	Input.action_release("ui_right")	
