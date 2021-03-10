extends Node2D

onready var boss = get_node("/root/BossArena/Entities/PersistentObjects/BossBat")
onready var change_level = $ChangeLevel

func _ready():
	boss.connect("collected", self, "game_complete")
	
func game_complete(_node):
	change_level.change_level()
