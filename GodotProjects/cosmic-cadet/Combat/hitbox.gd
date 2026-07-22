extends Area2D
class_name HitBox

signal died
signal took_damage(amount: float)
signal invincibility_ended

@onready var invincibility_timer : Timer = $InvincibilityTimer

@export var max_hp := 100.0
var current_hp := 100.0

var is_invincible := false

func _ready() -> void:
	current_hp = max_hp
	
func take_damage(amount: float) -> bool:
	if is_invincible: return false
	if amount <= 0.0: return false
	
	current_hp -= amount
	
	if current_hp <= 0.0:
		current_hp = 0.0
		died.emit()
	else:
		took_damage.emit(amount)
	return true

func heal(amount: float) -> void:
	if amount <= 0.0: return
	
	current_hp += amount
	
	if current_hp > max_hp: current_hp = max_hp
	
func die() -> void:
	is_invincible = false
	take_damage(current_hp)

func turn_invincible(seconds: float) -> void:
	if !is_invincible:
		is_invincible = true
		invincibility_timer.wait_time = seconds
		invincibility_timer.start()

func _on_invincibility_timer_timeout() -> void:
	is_invincible = false
	invincibility_ended.emit()