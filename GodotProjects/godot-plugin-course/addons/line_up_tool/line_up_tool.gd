@tool
extends EditorPlugin

var lineup_ui
var undo_redo = null

func _enter_tree() -> void:
	undo_redo = get_undo_redo()
	
	lineup_ui = preload("res://addons/line_up_tool/line_up_ui.tscn").instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, lineup_ui)
	lineup_ui.apply_button_pressed.connect(on_apply_button_pressed)


func _exit_tree() -> void:
	remove_control_from_docks(lineup_ui)
	lineup_ui.queue_free()
	
func on_apply_button_pressed(checkbutton_state, distance):
	if undo_redo == null:
		print("LineUpTool: Undo-redo manager is null!")
		return
	
	undo_redo.create_action("LineUpTool: Lined up the selected nodes.")
	
	var selectedNodes = EditorInterface.get_selection().get_selected_nodes()
	if selectedNodes.size() == 0:
		print("No nodes were selected")
		return
	
	var firstNode = selectedNodes[0]
	if !(firstNode is Node2D):
		print("LineUpTool: First node must be a Node2D")
		return
	
	var new_array = []
	for i in range(selectedNodes.size()):
		var node = selectedNodes[i]
		if node is Node2D:
			new_array.append(node)
	
	for i in range(1, new_array.size()):
		var node = new_array[i]
		if node is Node2D:
			var new_pos = firstNode.global_position
			
			if checkbutton_state:
				new_pos.y += distance * i
			else:
				new_pos.x += distance * i
			
			undo_redo.add_do_property(node, "global_position", new_pos)
			undo_redo.add_undo_property(node, "global_position", node.global_position)
			
	undo_redo.commit_action()
