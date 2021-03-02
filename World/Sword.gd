extends Node2D

var stats = PlayerStats
var pickup_sound = preload("res://Audio/Coin.wav")

signal collected(Node2D)

func _on_Area2D_body_entered(_body):
	stats.has_sword = true
	play_pickup_sound()
	emit_signal("collected", self)
	queue_free()

func play_pickup_sound():
	var player = AudioStreamPlayer.new()
	player.stream = pickup_sound
	player.connect("finished", player, "queue_free")
	get_parent().add_child(player)
	player.play()
