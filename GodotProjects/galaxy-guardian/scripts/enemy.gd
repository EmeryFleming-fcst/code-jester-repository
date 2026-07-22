extends Area2D
class_name Enemy

signal died

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var speed = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x -= speed * delta

func die() -> void:
	animation_player.play("explode")
	died.emit()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
		die()
