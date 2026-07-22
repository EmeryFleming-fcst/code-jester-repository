## Base Class for All States
class_name State extends Node

#region Signals

signal finished(next_state_path: String, data: Dictionary)

#endregion

#region Functions

## Called to receive unhandled input events.
func handle_input(_event: InputEvent) -> void:
	pass

## Called on the engine's main loop tick.
func update(_delta: float) -> void:
	pass

## Called on the engine's physics update tick.
func physics_update(_delta: float) -> void:
	pass

## Called by the state machince upon changing the active state.
func enter(previous_state_path: String, data := {}) -> void:
	pass
	
## Called by the state machine before changing the active state.
func exit() -> void:
	pass
	
#endregion