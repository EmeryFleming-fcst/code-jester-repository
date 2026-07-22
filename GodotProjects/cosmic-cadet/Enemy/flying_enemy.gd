extends CharacterBody2D

@onready var hitbox: HitBox = $Hitbox
@onready var end_position_marker: Marker2D = $EndPosition

@export var speed := 40.0
var direction := Vector2.UP

var start_position := Vector2.ZERO
var end_position := Vector2.ZERO
var destination := Vector2.ZERO

func _ready() -> void:
	start_position = global_position
	end_position = end_position_marker.global_position
	destination = end_position
	direction = (destination - global_position).normalized()
	
	hitbox.died.connect(_on_hit_box_dead)
	hitbox.took_damage.connect(_on_hit_box_took_damage)
	
func _physics_process(_delta: float) -> void:
	var dist_to_dest := global_position.distance_to(destination)
	
	if dist_to_dest < 1.0:
		if destination.is_equal_approx(end_position):
			destination = start_position
		else:
			destination = end_position
			
		direction = (destination - global_position).normalized()
			
	velocity = direction * speed
	
	move_and_slide()
	
func _on_hit_box_dead() -> void:
	Instancer.instance_scene_to_level(Instancer.explosion_effect_sc, global_position)
	AudioPlayer.play_sfx("explosion")	
	queue_free()
	
func _on_hit_box_took_damage(_amount: float) -> void:
	AudioPlayer.play_sfx("hurt")