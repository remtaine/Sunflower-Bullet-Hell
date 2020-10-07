class_name EnemyStatesHandler
extends Node2D

var inputs : Dictionary

func get_raw_input() -> Dictionary:
	inputs = {
		is_moving = true,
		input_direction = Vector2.RIGHT,
		is_shooting = true,
	}
	return inputs

func interpret_inputs(input):
	if input.is_moving:
		return "moving"
	else:
		return "idle"
