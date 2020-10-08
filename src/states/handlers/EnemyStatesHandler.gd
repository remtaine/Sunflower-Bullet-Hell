class_name EnemyStatesHandler
extends StatesHandler

func get_raw_input() -> Dictionary:
	inputs = {
		is_moving = true,
		input_direction = Vector2.RIGHT,
		is_shooting = true,
	}
	return inputs

func interpret_inputs(input) -> String:
	if input.is_moving:
		return "moving"
	else:
		return "idle"
