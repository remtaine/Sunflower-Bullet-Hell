class_name Enemy
extends Character

const ENEMY_BORDER_START = Vector2(120, 40)
const ENEMY_BORDER_END = Vector2(800, 450)
export (int) var points_on_death := 5000
signal enemy_died

onready var bullet_spawner = $BulletSpawners/BulletSpawner
var shoot_style := 0
var default_accel = 50
var aimed = false

func _ready():
	var _succesful_connection = connect("enemy_died",level,"update_score")
	set_aim()
	
func _process(_delta):
	set_aim()

func set_aim():
	for bs in bullet_spawners.get_children():
		if bs.get_aim_mode() == 3 or bs.get_aim_mode() == 2: #check if target_global
			if (GameInfo.current_player):
				bs.set_aim_target_position(GameInfo.current_player.hitbox_sprite.global_position)
			else:
				bs.set_autofire(false)
				
func die():
	emit_signal("enemy_died", points_on_death)
	.die()

func shoot():
	if (GameInfo.current_player):
		play_audio("shoot")
		for bs in bullet_spawners.get_children():
			bs.fire()

func set_shoot_style(s_style, bs := bullet_spawner):
	shoot_style = s_style
	reset_bullet(bs)
	
	match shoot_style:
		0: #linear
			bs.set_aim_mode(0)
			bs.set_shot_count(1)
			bs.set_arc_width_degrees(45)
			bs.set_interval_frames(9)
		1: #linear aim
			bs.set_aim_mode(3)
		2: #linear accel aim
			bs.set_aim_mode(3)
			bs.get_bullet_type().set_linear_acceleration(default_accel)
			bs.set_interval_frames(20)
		3: #spiral right
			bs.anim.play("AttackRotation")
			bs.set_interval_frames(10)
		4: #Spiral left
			bs.anim.play_backwards("AttackRotation")
			bs.set_interval_frames(10)
		5: #spiral 3-way right
			bs.set_shot_count(3)
			bs.set_arc_width_degrees(360)
			bs.anim.play("AttackRotation")
			bs.set_interval_frames(14)
		6: #spiral 3-way left
			bs.set_shot_count(3)
			bs.set_arc_width_degrees(360)
			bs.anim.play_backwards("AttackRotation")
			bs.set_interval_frames(14)
		7,8,9: #spiral 3-way right accel
			bs.set_shot_count(3)
			bs.anim.play("AttackRotation")
			bs.set_arc_width_degrees(360)
			bs.set_interval_frames(14)			
			bs.get_bullet_type().set_linear_acceleration(default_accel)
		-8: #spiral 3-way left accel
			bs.set_shot_count(3)
			bs.anim.play_backwards("AttackRotation")
			bs.set_arc_width_degrees(360)
			bs.set_interval_frames(14)
			bs.get_bullet_type().set_linear_acceleration(default_accel)
		-9: #spiral 3-way right decel
			bs.set_shot_count(3)
			bs.anim.play("AttackRotation")
			bs.set_interval_frames(14)
			bs.get_bullet_type().set_linear_acceleration(-default_accel)
			bs.get_bullet_type().set_rotation_degrees(180)
		-10: #spiral 3-way left decel
			bs.set_shot_count(3)
			bs.anim.play_backwards("AttackRotation")
			bs.set_interval_frames(14)
			bs.get_bullet_type().set_linear_acceleration(-default_accel)
#			bullet_spawner.get_bullet_type().set_rotation_degrees(180)
		10,11: #random aimed
			bs.set_aim_mode(3)
			bs.set_shot_count(5)
			bs.set_arc_width_degrees(120)
			bs.set_scatter_mode(1)
			bs.set_scatter_range_degrees(20)
			bs.set_interval_frames(50)
		100: #spiral 8-way left accel
			bs.set_shot_count(8)
			bs.set_arc_width_degrees(270)
			bs.anim.play("AttackRotation")
			bs.set_interval_frames(17)
			bs.get_bullet_type().set_linear_acceleration(default_accel)

func reset_bullet(bs : BulletSpawner):
	bs.set_aim_mode(0)
	bs.set_shot_count(1)
	bs.set_arc_width_degrees(30)
	bs.set_scatter_mode(0)
	bs.set_interval_frames(30)
	bs.get_bullet_type().set_linear_acceleration(0)
