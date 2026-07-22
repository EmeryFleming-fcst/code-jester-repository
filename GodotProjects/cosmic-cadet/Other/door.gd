extends Area2D

@export var next_level_scene: PackedScene = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player && next_level_scene != null:
		body.immobilize()
		await Fader.fade_in()
		get_tree().change_scene_to_packed.call_deferred(next_level_scene)