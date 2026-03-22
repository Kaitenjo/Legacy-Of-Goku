extends Node

func pause(start: float, end: float = 0) -> void:
	var time = randf_range(start, end)
	await get_tree().create_timer(time).timeout
