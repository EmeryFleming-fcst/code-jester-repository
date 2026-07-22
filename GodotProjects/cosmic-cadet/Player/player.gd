extends CharacterBody2D
class_name Player

signal hp_changed(max_hp: float, current_hp: float)
signal item_collected(item_name : String)
signal player_died

var jump_velocity := -300.0
var double_jump_velocity := -250
var move_speed := 100.0
var slow_down_delta := 10.0
var laser_speed := 300.0
var invincibility_duration := 3.0

var is_facing_left := false
var can_double_jump := true
var is_shooting := false
var can_shoot := true

var is_gun_unlocked := false
var is_double_jump_unlocked := false
var is_immobilized := false

@onready var player_sprite := %PlayerSprite
@onready var player_animator := %PlayerAnimationPlayer
@onready var hurt_animator : AnimationPlayer = $HurtAnimationPlayer
@onready var remote_transform: RemoteTransform2D = $RemoteTransform2D
@onready var hitbox: Area2D = $Hitbox
@export var muzzle_left : Marker2D
@export var muzzle_right : Marker2D
@export var shoot_cooldown : Timer

func _ready() -> void:
	shoot_cooldown.timeout.connect(_on_shoot_cooldown)
	hitbox.died.connect(_on_died)
	hitbox.took_damage.connect(_on_took_damage)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Shoot") && is_gun_unlocked:
		if !is_shooting && is_on_floor() && can_shoot:
			is_shooting = true
			player_animator.play("shoot")
		
##
## BUILT IN FUNCTIONS
func _physics_process(delta: float) -> void:
	# Apply Gravity
	if !is_on_floor(): velocity += get_gravity() * delta
	
	# Jump
	if Input.is_action_just_pressed("jump") && !is_immobilized:
		if is_on_floor():
			jump(jump_velocity)
		elif can_double_jump && is_double_jump_unlocked:
			jump(double_jump_velocity)
			can_double_jump = false
	
	# Move
	var direction := Input.get_axis("move_left", "move_right")
	if is_shooting || is_immobilized: direction = 0.0
	var is_moving := (direction > 0.0) || (direction < 0.0)
	
	if is_moving:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0.0, slow_down_delta)
	
	var was_on_floor := is_on_floor()
	
	# Make the character move
	move_and_slide()
	
	if !was_on_floor && is_on_floor():
		Instancer.instance_scene_to_level(Instancer.dust_effect_sc, 
		global_position)
		AudioPlayer.play_sfx("land")
	
	if is_double_jump_unlocked:
		if is_on_floor() && !can_double_jump:
			can_double_jump = true
	
	if is_moving:
		is_facing_left = direction < 0.0
		player_sprite.flip_h = is_facing_left
	
	if !is_shooting:
		if is_on_floor():
			if is_moving:
				player_animator.play("run")
			else:
				player_animator.play("idle")
		else:
			if velocity.y < 0.0:
				player_animator.play("jump")
			elif velocity.y > 0.0:
				player_animator.play("fall")

#region Movement Functions

func jump(force: float) -> void:
	velocity.y = force

func immobilize() -> void:
	is_immobilized = true
	hitbox.turn_invincible(99.0)

#endregion

#region Shooting Functions

func shoot() -> void:
	var muzzle_position := muzzle_left.global_position if is_facing_left else muzzle_right.global_position
	var laser_direction := Vector2.LEFT if is_facing_left else Vector2.RIGHT
	
	Instancer.instance_scene_to_level(Instancer.laser_effect_sc, 
	muzzle_position).launch(laser_direction, laser_speed)
	
	can_shoot = false
	is_shooting = Input.is_action_pressed("Shoot")
	shoot_cooldown.start()
	AudioPlayer.play_sfx("laser")
	
func _on_shoot_cooldown() -> void:
	can_shoot = true
	
	if is_shooting && Input.is_action_pressed("Shoot"):
		shoot()
	else:
		is_shooting = false

#endregion

#region Damage

func _on_died() -> void:
	Instancer.instance_scene_to_level(Instancer.big_explosion_sc, global_position)
	hp_changed.emit(hitbox.max_hp, hitbox.current_hp)
	player_died.emit()
	AudioPlayer.play_sfx("explosion")
	queue_free()
	
func _on_took_damage(_amount: float) -> void:
	hitbox.turn_invincible(invincibility_duration)
	hp_changed.emit(hitbox.max_hp, hitbox.current_hp)
	hurt_animator.play("hurt")
	AudioPlayer.play_sfx("hurt")
	
func _on_hitbox_invincibility_ended() -> void:
	hurt_animator.stop()
	
#endregion

#region Items

func collect_item(item_name: String) -> void:
	match item_name:
		"gun_item":
			collect_gun_item()
		"double_jump_item":
			collect_double_jump_item()
		"health_pack_item":
			collect_health_pack()
			
	item_collected.emit(item_name)
	AudioPlayer.play_sfx("pickup")

func collect_health_pack() -> void:
	hitbox.heal(10.0)
	hp_changed.emit(hitbox.max_hp, hitbox.current_hp)

func collect_gun_item() -> void:
	is_gun_unlocked = true

func collect_double_jump_item() -> void:
	is_double_jump_unlocked = true
	
#endregion
