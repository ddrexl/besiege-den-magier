extends AnimatedSprite

onready var player = $AnimationPlayer

func _ready():
	player.play("Shatter")
