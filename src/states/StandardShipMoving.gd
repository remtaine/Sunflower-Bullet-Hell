class_name StandardShipMoving
extends Moving

export (int) var move_distance = 200

func _ready() -> void:
	move_distance = (0.5 * move_distance) + (randf() * move_distance * 0.5)

func run(_input):
	owner.look_at(GameInfo.current_player.global_position)
	owner.velocity = inputs.input_direction * owner.speed
	owner.velocity = owner.move_and_slide(owner.velocity)
	if owner.global_position.distance_to(owner.goal_position) < 5:
		owner.change_state("StandShoot")

func get_raw_input() -> Dictionary:
	inputs = {
		is_moving = true,
		input_direction = owner.global_position.direction_to(owner.goal_position), #TODO change to direction to next waypoint
		is_shooting = false,
	}
	return inputs

func enter():
	var dir_to = owner.global_position.direction_to(GameInfo.current_player.global_position)
	owner.goal_position = owner.global_position + (dir_to * move_distance)

func exit():
	owner.goal_position = Vector2(-1,-1)

func interpret_inputs(input) -> String:
	return "Moving"
