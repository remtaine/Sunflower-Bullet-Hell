class_name Boss1StatesHandler
extends EnemyStatesHandler


func get_raw_input() -> Dictionary:
	match owner.phase:
		1:
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
			
		2:
			randomize()
			if !inputs or inputs.input_direction == Vector2.ZERO or inputs.input_direction == Vector2.LEFT or inputs.input_direction == Vector2.RIGHT:
				inputs = {
					is_moving = true,
					input_direction = Vector2.LEFT.rotated((randi() % 30)/57),
					is_shooting = true,
				}
			else:
				inputs.is_moving = true
				inputs.is_shooting = true
				
				if owner.global_position.x > 725 and inputs.input_direction.x > 0: #hit right
					inputs.input_direction = inputs.input_direction.rotated((randi() % 30 + 75)/57)
				elif owner.global_position.y > 420 and inputs.input_direction.y > 0: # hit bottome
					inputs.input_direction = inputs.input_direction.rotated((randi() % 30 + 75)/57)
				elif owner.global_position.x < 225 and inputs.input_direction.x < 0: #hit left
					inputs.input_direction = inputs.input_direction.rotated((randi() % 30 + 75)/57)
				elif owner.global_position.y < 20  and inputs.input_direction.y < 0: #$hit top
					inputs.input_direction = inputs.input_direction.rotated((randi() % 30 + 75)/57)
				else:
					inputs.input_direction = inputs.input_direction
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
