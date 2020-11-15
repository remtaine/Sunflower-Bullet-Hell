class_name DownShipMoving
extends Moving

export (float) var boost_multiplier = 1.0

func get_raw_input() -> Dictionary:
	var planned_waypoint = owner.waypoints[0]
	inputs = {
		is_moving = owner.position.distance_to(planned_waypoint) > 3,
		input_direction = owner.position.direction_to(planned_waypoint), 
		is_shooting = false,
	}
	return inputs

func interpret_inputs(input) -> String:
	return "Moving"

func run(input):
	if input.is_moving:
		owner.direction = input.input_direction
		owner.velocity = owner.direction * owner.speed
		owner.velocity = owner.move_and_slide(owner.velocity)
	else:
		owner.look_at(GameInfo.current_player.global_position)
		owner.direction = owner.position.direction_to(GameInfo.current_player.global_position) 
		owner.change_state("Charge")

func enter():
	owner.rotation_degrees = 90
	owner.speed *= boost_multiplier
	
func exit():
	owner.speed /= boost_multiplier
	yield(get_tree().create_timer(1.5), "timeout")
