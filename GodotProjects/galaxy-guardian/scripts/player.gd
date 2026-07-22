extends CharacterBody2D
class_name Player

signal shoot_projectile
signal died

@onready var animation_player: AnimationPlayer = $MainAnimationPlayer
@onready var flash_animation_player: AnimationPlayer = $FlashAnimationPlayer
@onready var muzzle: Marker2D = $Muzzle
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var invincibility_timer: Timer = $InvincibilityTimer
@onready var projectile_sound: AudioStreamPlayer = $ProjectileSound

var laser_sounds := [preload("res://assets/audio/shot 1.wav"), 
					 preload("res://assets/audio/shot 2.wav")]

var speed := 120
var is_alive := true
var is_invincible := false

func _process(_delta: float) -> void:
	if !is_alive: return
	
	if Input.is_action_just_pressed("shoot"):
		flash_animation_player.play("shoot_laser")

# Every frame
func _physics_process(_delta: float) -> void:
	if !is_alive: return
	
	var horizontal_dir := Input.get_axis("move_left", "move_right")
	var vertical_dir := Input.get_axis("move_up", "move_down")
	
	# Normalize the vector to prevent diagonal speed increase
	var direction := Vector2(horizontal_dir, vertical_dir).normalized()
	
	velocity = speed * direction
	move_and_slide()
	
	var viewport_size = get_viewport_rect().size
	
	global_position = global_position.clamp(Vector2.ZERO, viewport_size)
	
	if vertical_dir < 0.0:
		animation_player.play("up")
	elif vertical_dir > 0.0:
		animation_player.play("down")
	else:
		animation_player.play("default")
		

func shoot() -> void:
	shoot_projectile.emit()
	player_laser_sound()
	
func die() -> void:
	if is_invincible: return
	
	died.emit()
	is_alive = false
	animation_player.play("explode")
	
func respawn(spawn_position: Vector2) -> void:
	global_position = spawn_position
	is_alive = true
	sprite_2d.visible = true
	is_invincible = true
	invincibility_timer.start()

func _on_invincibility_timer_timeout() -> void:
	collision_shape_2d.set_deferred("disabled", false)
	is_invincible = false
	
func player_laser_sound():
	var sound_to_play = laser_sounds.pick_random()
	projectile_sound.stream = sound_to_play
	projectile_sound.play()
