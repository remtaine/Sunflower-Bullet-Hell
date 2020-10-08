class_name Background
extends ParallaxLayer

export (int) var scroll_velocity_x := 0
export (int) var scroll_velocity_y := 80
func _ready():
	pass

func _physics_process(delta):
	motion_offset.x += scroll_velocity_x * delta	
	motion_offset.y += scroll_velocity_y * delta
