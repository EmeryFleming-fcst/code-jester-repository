extends Area2D

@onready var collect_sound: AudioStreamPlayer2D = $CollectSound

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Asteroids"):
		body.queue_free()
		collect_sound.play()
	

func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
