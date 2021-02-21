extends Area2D

func is_glued_by_spider_webs():
	return len(get_overlapping_areas()) > 0
