extends Node

@onready var sfx_player_container: Node = $SFXStreamPlayerContainer

var sfx_players := []
var sounds := {
	"explosion" : preload("res://Assets/audio/Explosion.wav"),
	"hurt" : preload("res://Assets/audio/hurt_sound.wav"),
	"land" : preload("res://Assets/audio/land.wav"),
	"laser" : preload("res://Assets/audio/Laser_Shoot.wav"),
	"pickup" : preload("res://Assets/audio/pick-important.wav"),
	"shock" : preload("res://Assets/audio/shock.wav"),
}

func _ready() -> void:
	sfx_players = sfx_player_container.get_children()
	
func play_sfx(sfx_name: String) -> void:
	var sfx_to_use = sounds[sfx_name]
	
	var sfx_player: AudioStreamPlayer = parse_audio_streams()
	
	if sfx_player != null:
		sfx_player.stream = sfx_to_use
		sfx_player.play()
	
func parse_audio_streams() -> AudioStreamPlayer:
	var free_audio_player = null
	
	for sfx_player: AudioStreamPlayer in sfx_players:
		if !sfx_player.playing:
			free_audio_player = sfx_player
			break
	
	return free_audio_player