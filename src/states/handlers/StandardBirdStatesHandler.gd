class_name StandardBirdStatesHandler
extends EnemyStatesHandler


func get_raw_input() -> Dictionary:
	inputs = {
		is_moving = owner.position.distance_to(owner.goal_position) > 3,
		input_direction = owner.position.direction_to(owner.goal_position), #direction to goal_position
		is_shooting = owner.position.distance_to(owner.goal_position) < 3, #at goal_position
	}
	return inputs

func interpret_inputs(input) -> String:
	if input.is_moving:
		return "moving"
	else:
		return "standshoot"
