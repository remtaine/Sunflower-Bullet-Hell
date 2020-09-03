class_name Bird
extends Enemy

func _ready():
	._ready()
	
func _physics_process(delta):
	._physics_process(delta)
	
	if bullet_cd_timer.is_stopped():
		shoot()
#		bullet_patterns.shoot()
		bullet_cd_timer.start()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
#	position.y = -100
