extends Node2D

var heart_sound = preload("res://Audio/Heart.wav")

func play():
	var player = AudioStreamPlayer.new()
	player.stream = heart_sound
	player.volume_db = 15
	player.connect("finished", player, "queue_free")
	get_tree().current_scene.add_child(player)
	player.play()
