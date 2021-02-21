extends Node2D

const SpiderWeb = preload("res://Enemies/SpiderWeb.tscn")

export var attack_distance = 32
export var number_of_webs = 2

onready var attack_position = global_position
onready var player_position = global_position
onready var shooting_timer = $WebShootingTimer
onready var spider_webs_node = $SpiderWebs


func update_player_position(player_position_):
	player_position = player_position_

func get_attack_position():
	var distance_to_player = global_position.distance_to(player_position)
	var direction_to_player = global_position.direction_to(player_position)
	attack_position = global_position + direction_to_player  * (distance_to_player - attack_distance)
	return attack_position

func has_arrived_at_attack_position(position_):
	return position_.distance_to(attack_position) <= 4

func too_far_away_from_attack_position():
	return abs(global_position.distance_to(player_position) - attack_distance) > 4

func start_web_shooting(duration):
	shoot_spider_web()
	shooting_timer.start(duration)

func stop_web_shooting():
	shooting_timer.stop()

func _on_WebShootingTimer_timeout():
	start_web_shooting(rand_range(2,3))
		
func shoot_spider_web():
	if spider_webs_node.get_child_count() < number_of_webs:
		var spider_web = SpiderWeb.instance()
		spider_webs_node.add_child(spider_web)
		spider_web.global_position = global_position
		spider_web.velocity = global_position.direction_to(player_position) * 100
