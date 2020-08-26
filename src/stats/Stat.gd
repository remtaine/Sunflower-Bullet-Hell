class_name Stat
extends Node

export var value : int = 1
var max_value : int

func _ready():
	max_value = value
	
func update(val) -> bool:
	value -= val
	value = clamp(value, 0, max_value)

	return value <= 0
