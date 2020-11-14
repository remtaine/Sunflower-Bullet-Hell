class_name StandardBird
extends Enemy

export var goal_position : Vector2
func setup(pos, goal_pos, s_style):
	self.position = pos
	
	waypoints.append(goal_pos)
	
	if shoot_style == -1:
		set_shoot_style(s_style)
	else:
		set_shoot_style(shoot_style)
		
#	if position.distance_to(goal_position) <= 3 and shot_cooldown_timer.is_stopped():
#		shot_cooldown_timer.start()
