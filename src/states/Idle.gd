class_name Idle
extends State

onready var tween = $Tween

func _ready():
	state_name = "idle"

func enter():
	owner.velocity = Vector2.ZERO
	tween.interpolate_property(owner, "rotation_degrees", owner.rotation_degrees, 0, lean_duration/2, Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()

func interpret_inputs(input):
	if input.is_moving:
		return "moving"
	else:
		return state_name
