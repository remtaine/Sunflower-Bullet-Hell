class_name SidewaysBird
extends Enemy

export var dir = Vector2.RIGHT

func setup(pos, d):
	position = pos
	dir = d
	if dir.x < 0: #heading left!
		sprite_pivot.scale.x *= -1
	else:
		sprite_pivot.scale.x = abs(sprite_pivot.scale.x)

func _ready():
	speed *= 2.5
	shot_cooldown_timer.start()
	
func _physics_process(_delta):
	if dir.x > 0 and position.x > ENEMY_BORDER_END.x:
		position.x = ENEMY_BORDER_START.x
		speed /= 1.25
	
	if dir.x < 0 and position.x < ENEMY_BORDER_START.x:
		position.x = ENEMY_BORDER_END.x
		speed /= 1.25
