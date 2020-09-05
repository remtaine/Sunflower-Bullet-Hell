class_name State
extends Node

var state_name = "State"

onready var tween = $Tween

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
		"enemy", "bird":
			inputs = {
				is_moving = not owner.in_position(),
				input_direction = owner.goal_position_direction(),
				is_shooting = true,
			}
	return inputs
	
func interpret_inputs(input):
	match owner.character_type:
		"player":
			if input.is_moving:
				return "moving"
			else:
				return "idle"
		"enemy", "bird":
			if input.is_moving:
				return "moving"
			else:
				return "shooting"

func enter():
	pass

func exit():
	pass

func get_input_direction() -> Vector2:
	return Vector2(float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left")), float(Input.is_action_pressed("move_down")) - float(Input.is_action_pressed("move_up")))

func run(input):
	pass

func reset():
	owner.velocity = Vector2.ZERO
	tween.interpolate_property(owner, "rotation_degrees", owner.rotation_degrees, 0, lean_duration/2, Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()
