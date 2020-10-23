class_name StandardBird
extends Enemy

export var goal_position : Vector2
var shoot_style := 0
onready var bullet_spawner = $BulletSpawners/BulletSpawner
var default_accel = 100
var aimed = false

func setup(pos, goal_pos, s_style):
	position = pos
	goal_position = goal_pos
	set_shoot_style(s_style)
	
func set_shoot_style(s_style):
	shoot_style = s_style
	
	match shoot_style:
		1: #linear aim
			bullet_spawner.set_aim_mode(3)
			aimed = true
		2: #linear accel aim
			aimed = true			
			bullet_spawner.set_aim_mode(3)
			bullet_spawner.get_bullet_type().set_linear_acceleration(default_accel)
		3: #spiral right
			bullet_spawner.anim.play("AttackRotation")
			shot_cooldown_timer.wait_time = 0.15
		4: #Spiral left
			bullet_spawner.anim.play_backwards("AttackRotation")
			shot_cooldown_timer.wait_time = 0.15
		5: #spiral 3-way right
			bullet_spawner.set_shot_count(3)
			bullet_spawner.anim.play("AttackRotation")
			shot_cooldown_timer.wait_time = 0.1
		6: #spiral 3-way left
			bullet_spawner.set_shot_count(3)
			bullet_spawner.anim.play_backwards("AttackRotation")
			shot_cooldown_timer.wait_time = 0.1
		7: #spiral 3-way right accel
			bullet_spawner.set_shot_count(3)
			bullet_spawner.anim.play("AttackRotation")
			shot_cooldown_timer.wait_time = 0.1
			bullet_spawner.get_bullet_type().set_linear_acceleration(default_accel)
		8: #spiral 3-way left accel
			bullet_spawner.set_shot_count(3)
			bullet_spawner.anim.play_backwards("AttackRotation")
			shot_cooldown_timer.wait_time = 0.1
			bullet_spawner.get_bullet_type().set_linear_acceleration(default_accel)
		9: #spiral 3-way right decel
			bullet_spawner.set_shot_count(3)
			bullet_spawner.anim.play("AttackRotation")
			shot_cooldown_timer.wait_time = 0.1
			bullet_spawner.get_bullet_type().set_linear_acceleration(-default_accel)
			bullet_spawner.get_bullet_type().set_rotation_degrees(180)
		10: #spiral 3-way left decel
			bullet_spawner.set_shot_count(3)
			bullet_spawner.anim.play_backwards("AttackRotation")
			shot_cooldown_timer.wait_time = 0.1
			bullet_spawner.get_bullet_type().set_linear_acceleration(-default_accel)
			bullet_spawner.get_bullet_type().set_rotation_degrees(180)
		11: #random aimed
			aimed = true
			bullet_spawner.set_aim_mode(3)
			bullet_spawner.set_scatter_mode(1)
			bullet_spawner.set_scatter_range_degrees(30)
			shot_cooldown_timer.wait_time = 0.2
func _process(_delta):
	if aimed:
		if (GameInfo.current_player):
			bullet_spawner.set_aim_target_position(GameInfo.current_player.hitbox_sprite.global_position)
		else:
			shot_cooldown_timer.set_paused(true)
#	if position.distance_to(goal_position) <= 3 and shot_cooldown_timer.is_stopped():
#		shot_cooldown_timer.start()
