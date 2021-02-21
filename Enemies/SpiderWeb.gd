extends KinematicBody2D

var velocity = Vector2.ZERO
onready var player = $AnimationPlayer
onready var stats = $Health
onready var hurtbox = $WebHurtbox
onready var sprite = $Sprite

func _ready():
	player.play("expand")
	sprite.flip_h = randi() % 2 == 0

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = Vector2.ZERO

func _on_Lifetime_timeout():
	destroy_web()

func _on_Health_no_health():
	destroy_web()

func destroy_web():
	player.play("dissolve")
	
func _dissolve():
	queue_free()

func _on_WebHitBox_area_entered(_player_area):
	velocity = Vector2.ZERO

func _on_WebHurtbox_area_entered(sword):
	stats.health -= sword.damage
	hurtbox.start_invincibility()

func _on_FireHurtBox_deal_fire_damage(damage):
	stats.health -= damage
