class_name StandShoot
extends State

func _ready():
	pass

func run(_input):
	pass
	
func enter():
	for bs in owner.bullet_spawners.get_children():
		bs.set_autofire(true)
