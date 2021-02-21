extends Node2D

const PlayerFireSound = preload("res://Player/PlayerFireSound.tscn")
const FireWave = preload("res://Effects/FireWave.tscn")
const FireBall = preload("res://Effects/Fireball.tscn")

var facing_direction = Vector2.DOWN
var parent_node = null

func play_fire_sound():
	var fire_sound = PlayerFireSound.instance()
	parent_node.add_child(fire_sound)
	
func cast_fire_wave():
	play_fire_sound()
	var fire_wave = FireWave.instance()
	fire_wave.global_position = global_position
	parent_node.add_child(fire_wave)
	
func cast_fire_ball():
	play_fire_sound()
	var fire_ball = FireBall.instance()
	fire_ball.global_position = global_position
	fire_ball.direction = facing_direction
	parent_node.add_child(fire_ball)
