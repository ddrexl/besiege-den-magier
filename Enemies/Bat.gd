extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var KNOCKBACK = 150
export(int) var max_health = 2

signal no_health

enum {
	IDLE,
	WANDER,
	CHASE
}

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO
var state = IDLE
var chased_player = null

onready var sprite = $AnimatedSprite
onready var stats = $Health
onready var hurtbox = $Hurtbox
onready var player_detection_zone = $PlayerDetectionZone
onready var soft_collision = $SoftCollision
onready var state_transition = $WanderIdleStateTransitionTimer
onready var wander_controller = $WanderController
onready var blink_animation = $BlinkAnimationPlayer
onready var item_drop = $ItemDrop

func _ready():
	set_max_health(max_health)

func set_max_health(value):
	max_health = value
	stats.set_max_health(value)
	stats.set_health(value)

func _physics_process(delta):
	knockback = slow_down(knockback, delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = slow_down(velocity, delta)
				
		WANDER:
			accelerate_towards_position(wander_controller.target_position, delta)
			sprite.flip_h = velocity.x < 0
			
			if wander_controller.has_arrived_at_target_position(global_position):
				state = IDLE
			
		CHASE:
			accelerate_towards_position(chased_player.global_position, delta)
			sprite.flip_h = velocity.x < 0
	
	velocity = soft_collision.apply(velocity, delta)
	velocity = move_and_slide(velocity)
	

func accelerate_towards_position(position_, delta):
	var direction = global_position.direction_to(position_)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

func slow_down(velocity_, delta):
	return velocity_.move_toward(Vector2.ZERO, FRICTION * delta)


func _on_Stats_no_health():
	create_death_effect()
	item_drop.drop_item()
	emit_signal("no_health")
	queue_free()

func _on_WanderIdleStateTransitionTimer_timeout():
	state_transition.start(rand_range(1,3))
	var states = [WANDER, IDLE]
	if state in states:
		states.shuffle()
		var new_state =  states.pop_front()
		set_deferred("state", new_state)

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * KNOCKBACK
	hurtbox.start_invincibility()
	hurtbox.create_hit_effect()

func _on_PlayerDetectionZone_player_in_sight(player):
	chased_player = player
	state = CHASE

func _on_PlayerDetectionZone_player_out_of_sight():
	chased_player = null
	state = IDLE

func create_death_effect():
	var death_effect = EnemyDeathEffect.instance()
	get_tree().current_scene.add_child(death_effect)
	death_effect.global_position = global_position

func _on_Hurtbox_invincibility_ended():
	blink_animation.play("stop")

func _on_Hurtbox_invincibility_started():
	blink_animation.play("start")

func _on_FireHurtBox_deal_fire_damage(damage):
	stats.health -= damage
	hurtbox.create_hit_effect()
