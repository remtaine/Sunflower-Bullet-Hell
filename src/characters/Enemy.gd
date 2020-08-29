class_name Enemy
extends Character

onready var visibility = $Addons/VisibilityNotifier2D
onready var bullet_patterns = $Addons/BulletPatterns
var goal_position = Vector2.ZERO


func _ready():
	target = GameInfo.current_player
	add_to_group("enemies")
	character_type = "enemy"
	change_direction()
	default_shot_direction = Vector2.DOWN
	
func setup(pos : Vector2, goal_pos : Vector2, s_style := 1, shot_cd := 1.0):
	position = pos
	goal_position = global_position + goal_pos
	shoot_style = s_style
	$Timers/BulletCD.wait_time *= shot_cd
	
func change_direction(dir = "idle"):
	sprite.play(dir)

func _physics_process(delta):
	._physics_process(delta)
	
	if _state.inputs.is_shooting and _state.state_name == "idle" and bullet_cd_timer.is_stopped():
		shoot()
#		bullet_patterns.shoot()
		bullet_cd_timer.start()

#func shoot():
#	#checks bullet pool for free bullet
#		audio_shoot.play()
#
#		var b = bullet_resource.instance()
#		objects_holder.add_child(b)
#		#REPLACE THIS ^
#
#		#initializes that		
#		b.setup(bullet_spawn_point.global_position, Vector2.DOWN, character_type)
#		#REPLACE THIS ^
#
#		#do CD
#		bullet_cd_timer.start()

func in_position():
	var temp = global_position.distance_to(goal_position) < 2
	return temp

func goal_position_direction():
	var temp = (global_position.direction_to(goal_position))

	return temp
func damage(dmg = 1):
	if visibility.is_on_screen():
		.damage()

func die():
	get_tree().call_group("frames", "update_score", 5000)
	.die()
	
func _on_VisibilityNotifier2D_screen_exited():
	position.y = -100


func _on_BulletCD_timeout():
	shot_clock += 0.1

func shoot():
	.shoot()
	shoot_style = 11
	var bullet 
	var target_direction = global_position.direction_to(target.global_position)
	match shoot_style: #bullet.setup(pos, dir, ct, l_accel := Vector2.ZERO, c_accel := Vector2.ZERO, spd := speed)
				1: #boring shoot
					bullet = bullet_resource.instance()
					bullets_pool.add_child(bullet)
					bullet.setup(bullet_spawn_point.global_position, default_shot_direction, character_type)
				2: #linear lockon
					bullet = bullet_resource.instance()
					bullets_pool.add_child(bullet)
					bullet.setup(bullet_spawn_point.global_position, target_direction, character_type) 
				3: #linear accel
					bullet = bullet_resource.instance()
					bullets_pool.add_child(bullet)
					bullet.setup(bullet_spawn_point.global_position, default_shot_direction, character_type, 1.0) 
				4: #linear decel
					bullet = bullet_resource.instance()
					bullets_pool.add_child(bullet)
					bullet.setup(bullet_spawn_point.global_position, default_shot_direction, character_type, -0.3) 
				5: #linear accel aiming
					bullet = bullet_resource.instance()
					bullets_pool.add_child(bullet)
					bullet.setup(bullet_spawn_point.global_position, target_direction, character_type, 2.0) 
				6: #spiral right
					bullet = bullet_resource.instance()
					bullets_pool.add_child(bullet)
					bullet.setup(bullet_spawn_point.global_position, Vector2.RIGHT.rotated(shot_clock), character_type) 
				7: #spiral left
					bullet = bullet_resource.instance()
					bullets_pool.add_child(bullet)
					bullet.setup(bullet_spawn_point.global_position, Vector2.LEFT.rotated(-shot_clock), character_type) 
				8: #spiral multi right
					for i in range (4):
						bullet = bullet_resource.instance()
						bullets_pool.add_child(bullet)
						bullet.setup(bullet_spawn_point.global_position, Vector2.LEFT.rotated((1.57 * i) + (shot_clock)), character_type) 
				9: #spiral multi left
					for i in range (4):
						bullet = bullet_resource.instance()
						bullets_pool.add_child(bullet)
						bullet.setup(bullet_spawn_point.global_position, Vector2.LEFT.rotated((1.57 * i) - (shot_clock)), character_type) 
				10: #spiral multi double
					for i in range (4):
						bullet = bullet_resource.instance()
						bullets_pool.add_child(bullet)
						bullet.setup(bullet_spawn_point.global_position, Vector2.LEFT.rotated((1.57 * i) + (shot_clock)), character_type) 
						bullet = bullet_resource.instance()
						bullets_pool.add_child(bullet)
						bullet.setup(bullet_spawn_point.global_position, Vector2.LEFT.rotated((1.57 * i) - (shot_clock)), character_type) 
				11: #spiral multi oouble 2??? TODO FIX THIS
					for i in range (4):
						bullet = bullet_resource.instance()
						bullets_pool.add_child(bullet)
						bullet.setup(bullet_spawn_point.global_position, Vector2.LEFT.rotated((1.57 * (i + 1.5)) + (shot_clock)), character_type) 
						bullet = bullet_resource.instance()
						bullets_pool.add_child(bullet)
						bullet.setup(bullet_spawn_point.global_position, Vector2.LEFT.rotated((1.57 * i) - (shot_clock)), character_type) 
				12: #spiral right turn
					bullet = bullet_resource.instance()
					bullets_pool.add_child(bullet)
					bullet.setup(bullet_spawn_point.global_position, Vector2.UP.rotated(shot_clock), character_type, -1.0) 
