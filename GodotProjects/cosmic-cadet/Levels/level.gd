extends Node2D

@onready var player: Player = $Player
@onready var hud: Control = $UILayer/HUD
@onready var game_camera: Camera2D = $GameCamera
@onready var scene_reload_timer: Timer = $SceneReloadTimer

func _ready() -> void:
	player.remote_transform.remote_path = game_camera.get_path()
	
	hud.set_hb_values(player.hitbox.max_hp, player.hitbox.current_hp)
	player.hp_changed.connect(_on_player_hp_changed)
	player.item_collected.connect(_on_player_item_collected)
	player.player_died.connect(_on_player_died)
	scene_reload_timer.timeout.connect(_on_scene_reload_timeout)
	
	await Fader.fade_out()

func _process(_delta: float) -> void:
	# Quit Game and Reset Functionality
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	if Input.is_action_pressed("reset_game"):
		get_tree().reload_current_scene()
			
func _on_player_hp_changed(max_hp: float, current_hp: float) -> void:
	hud.set_hb_values(max_hp, current_hp)
	
func _on_player_item_collected(item_name: String) -> void:
	match item_name:
		"gun_item":
			hud.gun_texture.visible = true
		"double_jump_item":
			hud.double_jump_texture.visible = true
			
func _on_player_died() -> void:
	scene_reload_timer.start()
	
func _on_scene_reload_timeout() -> void:
	await Fader.fade_in()
	get_tree().reload_current_scene()