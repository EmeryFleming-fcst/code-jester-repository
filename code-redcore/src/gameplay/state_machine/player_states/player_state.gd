class_name PlayerState extends State

#region Constants

const IDLE: String = "Idle"
const WALKING: String = "Walking"
const DODGING: String = "DODGING"

#endregion

#region Variables

var player: MainPlayer = null

#endregion

#region Built-in Functions

func _ready() -> void:
	await owner.ready
	player = owner as MainPlayer
	
#endregion