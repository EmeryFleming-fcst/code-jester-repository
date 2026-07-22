@tool
extends Control

signal apply_button_pressed(check_button_state, distance)

func _on_apply_button_pressed() -> void:
	var cbs = %CheckButton.button_pressed
	var distance = %DistanceSpinBox.value
	apply_button_pressed.emit(cbs, distance)
