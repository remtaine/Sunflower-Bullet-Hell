class_name State
extends Node

export var state_name = "State"
var lean_duration = 0.2
var inputs = {
		is_moving = false,
		input_direction = Vector2.ZERO,
		is_shooting = false,
	}

func _ready():
	owner = get_parent().get_parent()

func get_raw_input() -> Dictionary:
	match owner.character_type:
		"player":
			inputs = {
				is_moving = Input.is_action_pressed("move_down") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up"),
				input_direction = get_input_direction(),
				is_shooting = Input.is_action_pressed("shoot"),
			}
		"enemy":
			inputs = {
				is_moving = not owner.in_position(),
				input_direction = Vector2.DOWN,
				is_shooting = true,
			}
#		"bullet":
#			inputs = {
#				is_moving = true,
#				input_direction = owner.direction,
#				is_shooting = false,
#			}
	return inputs
	
func interpret_inputs(input):
	return "idle"

func enter():
	pass

func exit():
	pass

func get_input_direction() -> Vector2:
	return Vector2(float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left")), float(Input.is_action_pressed("move_down")) - float(Input.is_action_pressed("move_up")))

func run(input):
	pass
