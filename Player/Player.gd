extends KinematicBody2D

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

enum {
	MOVE,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var stats = PlayerStats

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var hurtbox = $Hurtbox
onready var webbed_box = $WebbedBox
onready var blink_animation = $BlinkAnimationPlayer
onready var sword = $Sword
onready var fire_magic = $FireMagic

func _ready():
	stats.connect("no_health", self, "queue_free")
	animation_tree.active = true
	fire_magic.parent_node = get_parent()
	blink_animation.play("stop")
	set_spawn_location()
	set_spawn_facing()

func set_spawn_location():
	var level = get_tree().current_scene
	var location = Vector2.ZERO
	match stats.spawn_location:
		PlayerStats.SpawnLocation.NORTH:
			location = level.NORTH
		PlayerStats.SpawnLocation.SOUTH:
			location = level.SOUTH
		PlayerStats.SpawnLocation.EAST:
			location = level.EAST
		PlayerStats.SpawnLocation.WEST:
			location = level.WEST
		PlayerStats.SpawnLocation.A:
			location = level.A
		PlayerStats.SpawnLocation.B:
			location = level.B
		PlayerStats.SpawnLocation.C:
			location = level.C
		PlayerStats.SpawnLocation.D:
			location = level.D
	position = location

	
func set_spawn_facing():
	var direction = Vector2.DOWN
	match stats.spawn_facing:
		PlayerStats.SpawnFacing.UP:
			direction = Vector2.UP
		PlayerStats.SpawnFacing.DOWN:
			direction = Vector2.DOWN
		PlayerStats.SpawnFacing.LEFT:
			direction = Vector2.LEFT
		PlayerStats.SpawnFacing.RIGHT:
			direction = Vector2.RIGHT
	face_in_direction(direction)

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state()		

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		fire_magic.facing_direction = input_vector
		sword.knockback_vector = input_vector
		face_in_direction(input_vector)
		animation_state.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
	if Input.is_action_just_pressed("fire_wave"):
		fire_magic.cast_fire_wave()
	
	if Input.is_action_just_pressed("fire_ball"):
		fire_magic.cast_fire_ball()

func move():
	if webbed_box.is_glued_by_spider_webs():
		velocity = Vector2.ZERO
	else:
		velocity = move_and_slide(velocity)
		
func face_in_direction(direction):
	animation_tree.set("parameters/Idle/blend_position", direction)
	animation_tree.set("parameters/Run/blend_position", direction)
	animation_tree.set("parameters/Attack/blend_position", direction)

func attack_state():
	velocity = Vector2.ZERO
	animation_state.travel("Attack")

func attack_animation_finished():
	state = MOVE

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.start_invincibility()
	hurtbox.create_hit_effect()
	play_hurt_sound()
	
func play_hurt_sound():
	var hurt_sound = PlayerHurtSound.instance()
	get_parent().add_child(hurt_sound)
	
func _on_Hurtbox_invincibility_started():
	blink_animation.play("start")
	
func _on_Hurtbox_invincibility_ended():
	blink_animation.play("stop")
	
func _on_WebbedBox_glued_started():
	blink_animation.play("start")

func _on_WebbedBox_glued_ended():
	blink_animation.play("stop")
	state = MOVE
