class_name Boss2Moving
extends Boss1Moving

func run(input):
	owner.direction = input.input_direction.normalized()
	var mult = 1
	if Input.is_action_pressed("move_slow") and owner.is_in_group("allies"):
		mult = 0.5
	owner.velocity = owner.direction * owner.speed * mult
	owner.velocity = owner.move_and_slide(owner.velocity)
	
	match owner.phase:
		3:
			pass
#			owner.rotation_degrees += 5
			#TODO add tank spawn

func enter():
	match owner.phase:
		1:
			var x = 0
			owner.set_shoot_style(3, owner.bullet_spawners.get_child(x),0.5)
			owner.bullet_spawners.get_child(x).set_autofire(true)
			
			x = 1
			owner.set_shoot_style(2, owner.bullet_spawners.get_child(x),0.5)
			owner.bullet_spawners.get_child(x).set_autofire(true)
			
			x = 2
			owner.set_shoot_style(4, owner.bullet_spawners.get_child(x),0.5)
			owner.bullet_spawners.get_child(x).set_autofire(true)
			
#			x = 3
#			owner.set_shoot_style(1, owner.bullet_spawners.get_child(x))
#			owner.bullet_spawners.get_child(x).set_autofire(true)
		2: 
			var x = 0
			owner.set_shoot_style(3, owner.bullet_spawners.get_child(x),1)
			owner.bullet_spawners.get_child(x).set_autofire(true)
			
			x = 1
			owner.set_shoot_style(2, owner.bullet_spawners.get_child(x),1)
			owner.bullet_spawners.get_child(x).set_autofire(true)
			
			x = 2
			owner.set_shoot_style(4, owner.bullet_spawners.get_child(x),1)
			owner.bullet_spawners.get_child(x).set_autofire(true)
			
			owner.sprite.play("open")
			owner.summon_tank()
			owner.get_node("Timers/TankSpawn").start()
#			owner.speed *= 2
#			owner.set_shoot_style(0, owner.bullet_spawners.get_child(0))
#			owner.bullet_spawners.get_child(0).set_autofire(true)
		3: 
			owner.sprite.play("close")
			var x = 0
			owner.set_shoot_style(9, owner.bullet_spawners.get_child(x), 1.0)
			owner.bullet_spawners.get_child(x).set_autofire(true)
			
			x = 1
			owner.set_shoot_style(10, owner.bullet_spawners.get_child(x), 1.0)
			owner.bullet_spawners.get_child(x).set_autofire(true)
			
			x = 2
			owner.set_shoot_style(9, owner.bullet_spawners.get_child(x), 1.0)
			owner.bullet_spawners.get_child(x).set_autofire(true)
#			owner.bullet_spawners.get_child(1).set_autofire(true)
		4: 
			owner.set_shoot_style(100, owner.bullet_spawners.get_child(0))
			owner.set_shoot_style(1, owner.bullet_spawners.get_child(1))
			
			for bs in owner.bullet_spawners.get_children():
				bs.set_autofire(true)
			
func exit():
	for bs in owner.bullet_spawners.get_children():
		bs.set_autofire(false)
	
	match owner.phase:
		1:
			owner.sprite.play("empty")
		2:
#			owner.speed /= 2
			owner.rotation_degrees = 0

func tween_rotation_degrees(angle : int, duration := lean_duration):
	owner.tween.interpolate_property(owner.sprite_pivot,"rotation_degrees", owner.sprite_pivot.rotation_degrees, angle, duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	owner.tween.start()
