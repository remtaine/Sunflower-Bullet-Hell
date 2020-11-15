class_name DownShipCharge
extends State

func enter():
	owner.speed *= 1.5

func run(input):
	owner.velocity = owner.direction * owner.speed
	owner.velocity = owner.move_and_slide(owner.velocity)
	#TODO ADD QUEUE FREE
	if owner.position.y > GameInfo.GAME_BORDER_END.y + 100 or owner.position.y < GameInfo.GAME_BORDER_START.y - 100:
		owner.queue_free()
	elif owner.position.x > GameInfo.GAME_BORDER_END.x + 100 or owner.position.x < GameInfo.GAME_BORDER_START.x - 100:
		owner.queue_free()
		
func get_raw_input() -> Dictionary:
	inputs = {
		is_moving = true,
		input_direction = owner.global_position.direction_to(GameInfo.current_player.global_position), 
		is_shooting = false,
	}
	return inputs

func interpret_inputs(input) -> String:
	return "Charge"
