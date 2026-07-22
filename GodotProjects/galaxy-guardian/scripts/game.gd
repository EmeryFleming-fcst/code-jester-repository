extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var respawn_timer: Timer = $RespawnTimer
@onready var player_spawn_position: Marker2D = $PlayerSpawnPosition
@onready var hud: Control = $UILayer/HUD
@onready var ui_layer: CanvasLayer = $UILayer
@onready var player_death: AudioStreamPlayer = $PlayerDeath

var projectile_scene : PackedScene = preload("res://scenes/projectile.tscn")
var game_over_screen : PackedScene = preload("res://scenes/game_over_screen.tscn")

var lives := 3
var score := 0
var score_amount := 100

func _ready() -> void:
	player.shoot_projectile.connect(_on_player_shoot_projectile)
	player.died.connect(_on_player_died)
	
	hud.set_lives_label(lives)
	hud.set_score_label(score)
	
func _on_player_shoot_projectile():
	var projectile_instance = projectile_scene.instantiate()
	projectile_instance.global_position = player.muzzle.global_position
	
	add_child(projectile_instance)

func _on_enemy_spawner_enemy_spawned(instance: Variant) -> void:
	if instance is Enemy:
		instance.died.connect(_on_enemy_died)
		add_child(instance)

func _on_enemy_death_zone_area_entered(area: Area2D) -> void:
	if area is Enemy:
		area.queue_free()

func _on_player_died() -> void:
	lives -= 1
	hud.set_lives_label(lives)
	player_death.play()
	
	if lives > 0:
		respawn_timer.start()
	else:
		await get_tree().create_timer(1.5).timeout
		var game_over_inst = game_over_screen.instantiate()
		ui_layer.add_child(game_over_inst)

func _on_respawn_timer_timeout() -> void:
	player.respawn(player_spawn_position.global_position)

func _on_enemy_died() -> void:
	score += score_amount
	player_death.play()
	hud.set_score_label(score)
