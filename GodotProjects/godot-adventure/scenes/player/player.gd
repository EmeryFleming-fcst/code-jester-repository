extends CharacterBody2D

#region Export Variables

@export_category("Health Variables")
@export var hp := 10

@export_category("Movement Variables")
@export var move_speed := 100

#endregion

#region Scene References

@onready var sprite_animator : AnimatedSprite2D = $AnimatedSprite2D

#endregion

#region Built-in Functions

func _process(delta: float) -> void:
	var move_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_vector * move_speed
	
	movement_animation_selector(velocity)
	
	move_and_slide()
	
#endregion

#region Animation Functions

func movement_animation_selector(direction: Vector2):
	if velocity.x > 0:
		sprite_animator.play("walk_right")
	elif velocity.x < 0:
		sprite_animator.play("walk_left")
	elif velocity.y < 0:
		sprite_animator.play("walk_up")
	elif velocity.y > 0:
		sprite_animator.play("walk_down")
	else:
		sprite_animator.stop()

#endregion