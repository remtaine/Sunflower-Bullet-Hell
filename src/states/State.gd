class_name State
extends Node

export var is_manually_exited = false
export var disabled = false

var state_name = "State"

onready var states_handler = get_parent()
onready var tween = get_parent().get_node("StateAddons/Tween")

func _ready():
	owner = get_parent().get_parent()
	state_name = get_name()
	tween.connect("tween_completed", self, "_on_tween_completed")
	self.child_ready()
		
var inputs = {
		is_moving = false,
		input_direction = Vector2.ZERO,
		is_shooting = false,
	}

func child_ready():
	pass
	
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
			return "Moving"
		else:
			return "Idle"

func enter():
	pass

func exit():
	pass

func get_input_direction() -> Vector2:
	return Vector2(float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left")), float(Input.is_action_pressed("move_down")) - float(Input.is_action_pressed("move_up")))

func run(_input):
	pass

func _on_tween_completed(_object, _key):
	pass
