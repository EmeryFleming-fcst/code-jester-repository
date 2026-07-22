@tool
extends Button


# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	pressed.connect(custom_button_pressed)

func custom_button_pressed():
	print("Custom Button Pressed")
