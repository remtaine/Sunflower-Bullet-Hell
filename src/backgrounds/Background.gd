class_name Background
extends ParallaxLayer

export (int) var scroll_velocity_x := 0
export (int) var scroll_velocity_y := 80
export (bool) var use_delta = true

func _ready():
	pass

func _process(delta):
	if use_delta:
		motion_offset.x += scroll_velocity_x * delta	
		motion_offset.y += scroll_velocity_y * delta
	else:
		motion_offset.x += scroll_velocity_x# * delta	
		motion_offset.y += scroll_velocity_y# * delta
