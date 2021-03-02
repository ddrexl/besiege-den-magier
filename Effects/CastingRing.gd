extends Sprite

onready var player = $AnimationPlayer

func _ready():
	player.play("cast")
