extends Control

@onready var score_label: Label = $ScoreLabel
@onready var lives_label: Label = $Lives

func set_score_label(new_score: int) -> void:
	score_label.text = "SCORE: " + str(new_score)

func set_lives_label(lives: int) -> void:
	lives_label.text = str(lives)
