extends CharacterBody2D

@export var is_facing_left := false

@onready var hitbox: HitBox = $Hitbox
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var muzzle_left: Marker2D = $LeftMuzzle
@onready var muzzle_right: Marker2D = $RightMuzzle
@onready var shooting_timer: Timer = $ShootTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var muzzle: Marker2D = null
var fireball_dir := Vector2.ZERO
var fireball_speed := 200.0

func _ready() -> void:
	hitbox.died.connect(_on_hitbox_died)
	hitbox.took_damage.connect(_on_hitbox_took_damage)
	shooting_timer.timeout.connect(_on_shooting_timer_timeout)
	
	sprite_2d.flip_h = !is_facing_left
	muzzle = muzzle_right if !is_facing_left else muzzle_left
	fireball_dir = Vector2.RIGHT if !is_facing_left else Vector2.LEFT

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()
	
func _on_hitbox_died() -> void:
	Instancer.instance_scene_to_level(Instancer.explosion_effect_sc, global_position)	
	AudioPlayer.play_sfx("explosion")
	queue_free()

func _on_hitbox_took_damage(_amount: float) -> void:
	AudioPlayer.play_sfx("hurt")
	
func shoot() -> void:
	Instancer.instance_scene_to_level(Instancer.fireball_sc, muzzle.global_position).launch(fireball_dir, fireball_speed)

func _on_shooting_timer_timeout() -> void:
	animation_player.play("shoot")