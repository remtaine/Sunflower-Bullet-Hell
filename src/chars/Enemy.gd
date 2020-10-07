class_name Enemy
extends Character


func _physics_process(delta):
	if position.x > 800:
		position.x = 150
