extends Node

var dust_effect_sc : PackedScene = preload("res://FX/dust.tscn")
var laser_effect_sc : PackedScene = preload("res://Combat/laser.tscn")
var projectile_hit_effect_sc : PackedScene = preload("res://FX/projectile_hit_effect.tscn")
var explosion_effect_sc : PackedScene = preload("res://FX/explosion_effect.tscn")
var big_explosion_sc : PackedScene = preload("res://FX/big_explosion.tscn")
var fireball_sc : PackedScene = preload("res://Combat/fireball.tscn")
var item_pickup_sc : PackedScene = preload("res://FX/item_pickup_effect.tscn")

func instance_scene_to_level(scene: PackedScene, pos: Vector2) -> Node:
	var scene_instance := scene.instantiate()
	scene_instance.global_position = pos
	get_tree().current_scene.add_child(scene_instance)
	return scene_instance
