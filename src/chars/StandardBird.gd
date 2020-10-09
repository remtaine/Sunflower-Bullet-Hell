class_name StandardBird
extends Enemy

export var goal_position : Vector2
var shoot_style := 0

func setup(pos, goal_pos, s_style):
	position = pos
	goal_position = goal_pos
	set_shoot_style(s_style)
	
func set_shoot_style(s_style):
	shoot_style = s_style

func _process(delta):
	pass
#	if position.distance_to(goal_position) <= 3 and shot_cooldown_timer.is_stopped():
#		shot_cooldown_timer.start()
