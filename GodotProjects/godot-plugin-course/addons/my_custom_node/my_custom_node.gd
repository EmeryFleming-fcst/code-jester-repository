@tool
extends EditorPlugin


func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	add_custom_type("CustomButton", "Button", 
					preload("res://addons/my_custom_node/custom_button.gd"), 
					preload("res://icon.svg"))

func _exit_tree() -> void:
	remove_custom_type("CustomButton")
