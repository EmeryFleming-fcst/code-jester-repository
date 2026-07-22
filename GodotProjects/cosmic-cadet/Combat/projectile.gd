extends CharacterBody2D

var speed := 100.0
var direction := Vector2.ZERO

var clean_up_time := 3.0

@onready var laser_sprite : Sprite2D = %LaserSprite 
@onready var hurtbox: Area2D = $Hurtbox

func _ready() -> void:
	hurtbox.damage_applied.connect(_on_hurt_box_damage_applied)
	hurtbox.body_entered.connect(_on_hurt_box_body_entered)

func _physics_process(_delta: float) -> void:
	velocity = direction * speed
	move_and_slide()

func launch(dir: Vector2, move_speed: float) -> void:
	direction = dir
	speed = move_speed
	
	if direction.x < 0.0:
		laser_sprite.flip_h = true
		
	get_tree().create_timer(clean_up_time).timeout.connect(projectile_clean_up)

func projectile_clean_up() -> void:	
	queue_free()
	
func projectile_splash_effect() -> void:
	Instancer.instance_scene_to_level(Instancer.projectile_hit_effect_sc, global_position)

func _on_hurt_box_damage_applied() -> void:
	projectile_splash_effect()
	projectile_clean_up()

func _on_hurt_box_body_entered(_body: Node2D) -> void:
	projectile_splash_effect()
	projectile_clean_up()