class_name StateMachine extends Node

#region Export Variables

@export var initial_state: State = null

#endregion

#region Variables

var current_state : State = null
var states: Dictionary[Variant, Variant] = {}

#endregion

#region Built-in Functions

func _ready() -> void:
	# Get all the states
	for state_node : State in get_children():
		# Add it to the dictionary. Use the node name as the state name. Connect the signal
		states[state_node.name] = state_node
		state_node.finished.connect(_transition_to_next_state)
	
	# Set the default state
	if initial_state == null && !states.is_empty(): current_state = states.values()[0]
	
	await owner.ready
	current_state.enter("")

## Handles process calls
func _process(delta: float) -> void:
	current_state.update(delta)

## Handles physsics process calls
func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)

#endregion

#region Helper Functions

## Takes cares of any unhandled input
func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)

## Handles the transition from the current state to the next state.
func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	# Early out
	if not has_node(target_state_path): return
	
	# Transition to the next state
	var previous_state_path := current_state.name
	current_state.exit()
	current_state = states.get(target_state_path)
	current_state.enter(previous_state_path, data)

#endregion
