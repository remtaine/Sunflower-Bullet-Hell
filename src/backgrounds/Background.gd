extends ParallaxLayer


func _ready():
	pass

func _physics_process(delta):
	motion_offset.y += 100 * delta
