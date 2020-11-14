class_name DownBirdStatesHandler
extends EnemyStatesHandler

func get_raw_input() -> Dictionary:
	inputs = {
		is_moving = true,
		input_direction = owner.dir,
		is_shooting = false,
	}
	return inputs
