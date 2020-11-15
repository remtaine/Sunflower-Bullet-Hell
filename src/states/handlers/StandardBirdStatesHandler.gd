class_name StandardBirdStatesHandler
extends EnemyStatesHandler


func get_raw_input() -> Dictionary:
	var planned_waypoint = owner.goal_position
	inputs = {
		is_moving = owner.position.distance_to(planned_waypoint) > 3,
		input_direction = owner.position.direction_to(planned_waypoint), 
		is_shooting = owner.position.distance_to(planned_waypoint) < 3,
	}
	return inputs

func interpret_inputs(input) -> String:
	if input.is_moving:
		return "Moving"
	else:
		return "StandShoot"
