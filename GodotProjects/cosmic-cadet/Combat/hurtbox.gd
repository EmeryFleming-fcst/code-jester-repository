extends Area2D

signal damage_applied

@export var damage := 10
@export var one_shot := true

var to_damage : HitBox = null
var is_active := true

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	
func _process(_delta: float) -> void:
	if is_active && (to_damage != null):
		apply_damage(to_damage)
	
func apply_damage(hitxbox: HitBox) -> bool:
	var success := hitxbox.take_damage(damage)
	
	if success:
		damage_applied.emit()
	
	return success 
	
func _on_area_entered(area: Area2D) -> void:
	if !is_active : return
	
	if area is HitBox:
		var success := apply_damage(area)
		
		if one_shot:
			if success:
				is_active = false
		else:
			to_damage = area

func _on_area_exited(area: Area2D) -> void:
	if area is HitBox:
		if area == to_damage:
			to_damage = null