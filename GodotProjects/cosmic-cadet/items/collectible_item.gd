extends Area2D

@export var item_name: String = ""

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Instancer.instance_scene_to_level(Instancer.item_pickup_sc, global_position)
		body.collect_item(item_name)
		queue_free()