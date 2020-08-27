class_name Moving
extends State

export var speed : int = 320
var last_direction : Vector2 = Vector2.ZERO

onready var tween = $Tween

func _ready():
	state_name = "moving"

func run(input):
	owner.direction = input.input_direction.normalized()
	owner.velocity = owner.direction * speed
#	host.move_and_slide(velocity)
	match owner.character_type:
		"player":
			if owner.velocity.x < 0:
				owner.is_flipped = false
				owner.change_direction("left")
				tween.interpolate_property(owner, "rotation_degrees", owner.rotation_degrees, -10, lean_duration, Tween.TRANS_LINEAR,Tween.EASE_IN)		
				tween.start()
			elif owner.velocity.x > 0:
				owner.is_flipped = false
				owner.change_direction("right")
				tween.interpolate_property(owner, "rotation_degrees", owner.rotation_degrees, 10, lean_duration, Tween.TRANS_LINEAR,Tween.EASE_IN)
				tween.start()
		"enemy":
			if owner.velocity.x > 0:
				owner.is_flipped = false
				owner.change_direction("left")
				tween.interpolate_property(owner, "rotation_degrees", owner.rotation_degrees, -10, lean_duration, Tween.TRANS_LINEAR,Tween.EASE_IN)		
				tween.start()
			elif owner.velocity.x < 0:
				owner.is_flipped = false
				owner.change_direction("right")
				tween.interpolate_property(owner, "rotation_degrees", owner.rotation_degrees, 10, lean_duration, Tween.TRANS_LINEAR,Tween.EASE_IN)
				tween.start()
	if owner.velocity.y < 0:
		owner.change_direction("up")
	elif owner.velocity.y > 0:
		owner.change_direction("down")
#	tween.interpolate_property(host,"position", host.position, host.position + velocity, 0.2, Tween.TRANS_LINEAR,Tween.EASE_IN)
#	tween.start()
	
func exit():
	tween.stop_all()
