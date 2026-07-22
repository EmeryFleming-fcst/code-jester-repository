extends Control

@onready var play_btn : Button = $PlayButton
@onready var quit_btn : Button = $QuitButton

func _ready() -> void:
	Fader.fade_out()
	
	play_btn.pressed.connect(_on_play_btn_pressed)
	quit_btn.pressed.connect(_on_quit_btn_pressed)
	
func _on_play_btn_pressed() -> void:
	await Fader.fade_in()
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")
	
func _on_quit_btn_pressed() -> void:
	get_tree().quit()
