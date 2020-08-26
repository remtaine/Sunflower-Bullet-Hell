class_name Shooting
extends State

var last_direction : Vector2 = Vector2.ZERO

onready var tween = $Tween

func _ready():
	state_name = "shooting"

func run(input):
	pass
	
func interpret_inputs(input):
	if true:#in position:
		return state_name
	if false: #not in position
		return "moving"
	else:
		return "idle"

func exit():
	pass
