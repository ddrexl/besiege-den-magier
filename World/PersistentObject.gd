extends Node2D

func _ready():
	for node in get_children():
		node.connect("collected", self, "mark_as_collected")
		if was_collected(node):
			node.queue_free()

func mark_as_collected(node):
	GameProgress.collected_items.append(node.get_path())

func was_collected(node):
	return node.get_path() in GameProgress.collected_items
