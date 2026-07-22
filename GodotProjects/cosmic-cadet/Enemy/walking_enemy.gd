extends CharacterBody2D

@export var enemy_sprite : Sprite2D
@onready var right_ray_down: RayCast2D = $RightRayDown
@onready var left_ray_down: RayCast2D = $LeftRayDown
@onready var right_ray: RayCast2D = $RightRay
@onready var left_ray: RayCast2D = $LeftRay
@onready var hitbox: Area2D = $Hitbox

var speed := 30.0
var direction := 1.0

func _ready() -> void:
	hitbox.died.connect(_on_died)
	hitbox.took_damage.connect(_on_took_damage)

func _physics_process(delta: float) -> void:
	if !is_on_floor(): velocity += get_gravity() * delta
	
	if !right_ray_down.is_colliding():
		direction *= -1.0
		
	if !left_ray_down.is_colliding():
		direction *= -1.0
		
	if right_ray.is_colliding():
		direction *= -1.0
		
	if left_ray.is_colliding():
		direction *= -1.0
	
	velocity.x = direction * speed
	
	move_and_slide()
	
	enemy_sprite.flip_h = direction > 0.0
	
#region Damage

func _on_died() -> void:
	Instancer.instance_scene_to_level(Instancer.explosion_effect_sc, global_position)
	AudioPlayer.play_sfx("explosion")
	queue_free()

func _on_took_damage(_amount: float) -> void:
	AudioPlayer.play_sfx("hurt")

#endregion
