class_name Moving
extends State

export var speed : int = 160
var last_direction : Vector2 = Vector2.ZERO

onready var tween = $Tween

func _ready():
	state_name = "moving"
	owner = get_parent().get_parent()

func run(input):
	owner.direction = input.input_direction.normalized()
	owner.velocity = owner.direction * speed
#	host.move_and_slide(velocity)
#	tween.interpolate_property(host,"position", host.position, host.position + velocity, 0.2, Tween.TRANS_LINEAR,Tween.EASE_IN)
#	tween.start()
	owner.velocity = owner.move_and_slide(owner.velocity)
