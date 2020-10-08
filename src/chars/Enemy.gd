class_name Enemy
extends Character


func _ready():
	pass

func _physics_process(_delta):
	if position.x > 800:
		position.x = 150
