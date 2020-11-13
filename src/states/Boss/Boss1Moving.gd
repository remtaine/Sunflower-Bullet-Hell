class_name Boss1Moving
extends State

var last_direction : Vector2 = Vector2.ZERO
export (bool) var lean_on_move = false
export (int) var lean_angle = 10
export (float) var lean_duration = 0.5

func run(input):
	owner.direction = input.input_direction.normalized()
	var mult = 1
	if Input.is_action_pressed("move_slow") and owner.is_in_group("allies"):
		mult = 0.5
	owner.velocity = owner.direction * owner.speed * mult
	owner.velocity = owner.move_and_slide(owner.velocity)
	
	match owner.phase:
		2:
			owner.rotation_degrees += 3

func enter():
	print(owner.phase)
	match owner.phase:
		1:
			owner.set_shoot_style(11, owner.bullet_spawners.get_child(0))
			owner.bullet_spawners.get_child(0).set_autofire(true)
		2: 
			owner.speed *= 2
			owner.set_shoot_style(0, owner.bullet_spawners.get_child(0))
			owner.bullet_spawners.get_child(0).set_autofire(true)
		3: 
			owner.set_shoot_style(100, owner.bullet_spawners.get_child(0))
			owner.set_shoot_style(1, owner.bullet_spawners.get_child(1))
#			owner.bullet_spawners.get_child(1).set_autofire(true)
			
			for bs in owner.bullet_spawners.get_children():
				bs.set_autofire(true)
			
func exit():
	for bs in owner.bullet_spawners.get_children():
		bs.set_autofire(false)
	
	match owner.phase:
		2:
			owner.speed /= 2
			owner.rotation_degrees = 0

func tween_rotation_degrees(angle : int, duration := lean_duration):
	owner.tween.interpolate_property(owner.sprite_pivot,"rotation_degrees", owner.sprite_pivot.rotation_degrees, angle, duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	owner.tween.start()
