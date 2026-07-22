class_name SceneLoader extends Node2D

#region Preloads

@onready var player : PackedScene = preload("res://src/gameplay/player/main_player.tscn")

#endregion

#region Export Variables

@export_category("Scene Tree")
@export var entity_node : Node2D

#endregion

#region Built-in Functions

func _ready() -> void:
	
	# Spawn the Player
	_load_level()

#endregion


#region Helper Functions

func _load_level() -> void:
	_player_spawner()

func _player_spawner() -> void:
	if entity_node == null || player == null: return
	
	var player_instance : MainPlayer = player.instantiate()
	
	# Set the global location of the player to the spawnpoint location in the level.
	
	# Set the player to the child of the player_node.
	entity_node.add_child(player_instance)

#endregion
