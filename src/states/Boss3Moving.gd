class_name Boss3Moving
extends Boss1Moving

func run(input):
	match owner.phase:
		3:
			owner.rotation_degrees += 3
	.run(input)
func enter():
	match owner.phase:
		1:
			owner.set_shoot_style(100, owner.bullet_spawners.get_child(0))
			owner.bullet_spawners.get_child(0).set_autofire(true)
		2: 
			owner.speed *= 2
			owner.set_shoot_style(100, owner.bullet_spawners.get_child(0))
			owner.bullet_spawners.get_child(0).set_autofire(true)
		3: 
			owner.set_shoot_style(100, owner.bullet_spawners.get_child(0))
			owner.set_shoot_style(10, owner.bullet_spawners.get_child(1))
#			owner.bullet_spawners.get_child(1).set_autofire(true)
			
			for bs in owner.bullet_spawners.get_children():
				bs.set_autofire(true)
