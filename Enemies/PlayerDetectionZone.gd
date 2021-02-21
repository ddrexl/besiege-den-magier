extends Area2D

signal player_in_sight
signal player_out_of_sight

func _on_PlayerDetectionZone_body_entered(body):
	emit_signal("player_in_sight", body)

func _on_PlayerDetectionZone_body_exited(_body):
	emit_signal("player_out_of_sight")
