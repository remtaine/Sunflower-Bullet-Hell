class_name Shooting
extends State

var last_direction : Vector2 = Vector2.ZERO
export var speed : int = 320

func _ready():
	state_name = "shooting"

func run(input):
	if inputs.is_shooting and owner.bullet_cd_timer.is_stopped():
		owner.shoot()
		owner.bullet_cd_timer.start()
	match owner.move_style:
		0:
			pass
		1:
			owner.velocity = Vector2.RIGHT * speed
			
func interpret_inputs(input):
	if true:#in position:
		return state_name
	if false: #not in position
		return "moving"
	else:
		return "idle"

func enter():
	reset()

func exit():
	pass
