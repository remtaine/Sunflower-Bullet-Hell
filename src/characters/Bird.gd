class_name Bird
extends Enemy

func _ready():
	._ready()
	move_style = 1
	hp = 1
	
func _physics_process(delta):
	._physics_process(delta)
	
	if bullet_cd_timer.is_stopped():
		shoot()
		bullet_cd_timer.start()

	if position.x > GameInfo.LEVEL_BORDER_RIGHT:
		position.x = GameInfo.LEVEL_BORDER_LEFT
