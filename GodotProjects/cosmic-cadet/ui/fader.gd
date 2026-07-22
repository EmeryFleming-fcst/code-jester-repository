extends CanvasLayer

@onready var color_rect : ColorRect = $ColorRect

func fade_in(duration: float = 1.0, extra_wait_time: float = 0.5) -> void:
	color_rect.color.a = 0.0	
	var tween := get_tree().create_tween()
	tween.tween_property(color_rect, "color:a", 1.0, duration)
	
	await get_tree().create_timer(duration + extra_wait_time).timeout
	
func fade_out(duration: float = 1.0, extra_wait_time: float = 0.5) -> void:
	color_rect.color.a = 1.0
	await get_tree().create_timer(extra_wait_time).timeout
	
	var tween := get_tree().create_tween()
	tween.tween_property(color_rect, "color:a", 0.0, duration)
	
	await get_tree().create_timer(duration).timeout