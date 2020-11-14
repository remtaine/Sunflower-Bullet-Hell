class_name StandardBirdMoving
extends Moving

func _ready():
	pass
	
func run(input):
	owner.direction = input.input_direction.normalized()
	owner.velocity = owner.direction * owner.speed
	owner.velocity = owner.move_and_slide(owner.velocity)
