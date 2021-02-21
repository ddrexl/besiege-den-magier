extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

export var ACCELERATION = 200
export var MAX_SPEED = 30
export var FRICTION = 200
export var KNOCKBACK = 150

enum {
	IDLE,
	WANDER,
	JUMP,
	CHASE,
	ATTACK,
	STUNNED,
}

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO
var state = IDLE
var chased_player = null

onready var chase_marker = $ChaseMarker

onready var animation = $AnimationPlayer
onready var sprite = $Sprite
onready var stats = $Health
onready var hitbox = $Hitbox
onready var hurtbox = $Hurtbox
onready var player_detection_zone = $PlayerDetectionZone
onready var soft_collision = $SoftCollision
onready var state_transition = $WanderIdleStateTransitionTimer
onready var wander_controller = $WanderController
onready var attack_controller = $SpiderAttackController
onready var life_bar = $Lifebar
onready var item_drop = $ItemDrop

func _physics_process(delta):
	knockback = slow_down(knockback, delta)
	knockback = move_and_slide(knockback)
	chase_marker.global_position = global_position
	
	match state:
		IDLE:
			animation.play("idle")
			velocity = slow_down(velocity, delta)
				
		WANDER:	
			animation.play("move")
			
			accelerate_towards_position(wander_controller.target_position, delta)
			sprite.flip_h = velocity.x > 0
			
			if wander_controller.has_arrived_at_target_position(global_position):
				state = IDLE
			
		CHASE:
			animation.play("jump")
			attack_controller.update_player_position(chased_player.global_position)
			var attack_position = attack_controller.get_attack_position()
			chase_marker.global_position = attack_position
			accelerate_towards_position(attack_position, delta)
			sprite.flip_h = velocity.x > 0
			
			if attack_controller.has_arrived_at_attack_position(global_position):
				attack_controller.start_web_shooting(2)
				state = ATTACK
		
		ATTACK:
			animation.play("attack")
			attack_controller.update_player_position(chased_player.global_position)
			
			velocity = slow_down(velocity, delta)
			sprite.flip_h = global_position.x < chased_player.global_position.x
			
			if attack_controller.too_far_away_from_attack_position():
				attack_controller.stop_web_shooting()
				state = CHASE
			
		STUNNED:
			animation.play("on_back")	
			velocity = slow_down(velocity, delta)
			hitbox.collision_shape.set_deferred("disabled", true)
			life_bar.visible = false


	velocity = soft_collision.apply(velocity, delta)
	velocity = move_and_slide(velocity)
	

func accelerate_towards_position(position_, delta):
	var direction = global_position.direction_to(position_)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

func slow_down(velocity_, delta):
	return velocity_.move_toward(Vector2.ZERO, FRICTION * delta)

func _on_Stats_no_health():
	state = STUNNED

func _on_PlayerDetectionZone_player_in_sight(player):
	if not state == STUNNED:
		chased_player = player
		state = CHASE
	
func _on_PlayerDetectionZone_player_out_of_sight():
	if not state == STUNNED:
		chased_player = null
		state = WANDER

func _on_Hurtbox_area_entered(area):
	if not state == STUNNED:
		stats.health -= area.damage
		animation.play("damage")
		knockback = area.knockback_vector * KNOCKBACK
		hurtbox.start_invincibility()
		hurtbox.create_hit_effect()
	
func create_death_effect():
	var death_effect = EnemyDeathEffect.instance()
	get_tree().current_scene.add_child(death_effect)
	death_effect.global_position = global_position
	
func _on_WanderIdleStateTransitionTimer_timeout():
	state_transition.start(rand_range(1,3))
	var states = [WANDER, IDLE]
	if state in states:
		states.shuffle()
		var new_state =  states.pop_front()
		set_deferred("state", new_state)

func _on_FireHurtBox_deal_fire_damage(damage):
	if not state == STUNNED:
		stats.health -= damage
		hurtbox.create_hit_effect()
	
func _on_FireHurtBox_fire_ended():
	if state == STUNNED:
		death()

func death():
	create_death_effect()
	item_drop.drop_item()
	queue_free()

