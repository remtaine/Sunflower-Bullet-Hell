class_name StandShoot
extends State

func _ready():
	state_name = "standshoot"

func run(input):
	pass
	
func enter():
	owner.shot_cooldown_timer.start()
