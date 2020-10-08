class_name State
extends Node

export var state_name = "State"
onready var states_handler = get_parent()

var inputs = {
		is_moving = false,
		input_direction = Vector2.ZERO,
		is_shooting = false,
	}
	
func get_raw_input() -> Dictionary:
	if states_handler.has_method("get_raw_input"):
		inputs = states_handler.get_raw_input()
	else:
		inputs = {
			is_moving = Input.is_action_pressed("move_down") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up"),
			input_direction = get_input_direction(),
			is_shooting = Input.is_action_pressed("shoot"),
		}
	return inputs

func interpret_inputs(input) -> String:
	if states_handler.has_method("interpret_inputs"):
		return states_handler.interpret_inputs(input)
	else:
		if input.is_moving:
			return "moving"
		else:
			return "idle"

func enter():
	pass

func exit():
	pass

func get_input_direction() -> Vector2:
	return Vector2(float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left")), float(Input.is_action_pressed("move_down")) - float(Input.is_action_pressed("move_up")))

func run(_input):
	pass
