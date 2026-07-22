extends Control

@onready var health_bar : ProgressBar = $HealthBar
@onready var gun_texture : TextureRect = $GunTexture
@onready var double_jump_texture : TextureRect = $DoubleJumpTexture

func set_hb_values(max_hp: float, hp: float) -> void:
	health_bar.max_value = max_hp
	health_bar.value = hp