extends Node2D

onready var sword_hitbox = $HitboxPivot/SwortHitbox

var knockback_vector = Vector2.DOWN setget set_knockback_vector

func set_knockback_vector(vector):
	sword_hitbox.knockback_vector = vector

func _ready():
	self.knockback_vector = Vector2.DOWN
