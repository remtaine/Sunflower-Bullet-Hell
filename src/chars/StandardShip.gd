class_name StandardShip
extends Enemy

export var goal_position := Vector2(-1,-1)

func _ready() -> void:
	set_shoot_style(0)
	$Timers/ShootBurst.wait_time = 1.0 + (randf() * 1.5)
	goal_position = GameInfo.current_player.global_position
	
func setup(pos, s_style = 0, bullet_frequency = 1):
	self.position = pos
	
	if shoot_style == -1:
		set_shoot_style(s_style, bullet_spawner, bullet_frequency)
	else:
		set_shoot_style(shoot_style, bullet_spawner, bullet_frequency)

func _process(delta: float) -> void:
	pass
#	if position.distance_to(goal_position) <= 3 and shot_cooldown_timer.is_stopped():
#		shot_cooldown_timer.start()
