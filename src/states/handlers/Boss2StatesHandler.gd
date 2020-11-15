class_name Boss2StatesHandler
extends EnemyStatesHandler


func get_raw_input() -> Dictionary:
	match owner.phase:
		1,2:
			if !inputs or (inputs.input_direction == Vector2.LEFT and owner.global_position.x < 250):
				inputs = {
					is_moving = true,
					input_direction = Vector2.RIGHT,
					is_shooting = true,
				}
			elif inputs.input_direction == Vector2.RIGHT and owner.global_position.x > 725:
				inputs = {
					is_moving = true,
					input_direction = Vector2.LEFT,
					is_shooting = true,
			}
		_:
			inputs = {
					is_moving = true,
					input_direction = Vector2.ZERO,
					is_shooting = true,
			}
	return inputs

#func interpret_inputs(input) -> String:
#	if input.is_moving:
#		return "moving"
#	else:
#		return "idle"
