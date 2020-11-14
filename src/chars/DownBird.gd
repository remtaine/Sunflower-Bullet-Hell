class_name DownBird
extends Enemy

export var dir = Vector2.DOWN
export (float) var speed_multiplier = 1.5

func setup(pos):
	position = pos

func _ready():
	speed *= speed_multiplier
	for bs in bullet_spawners.get_children():
		bs.set_autofire(false)
	
func _physics_process(_delta):
	if dir.y > 0 and position.y > GameInfo.GAME_BORDER_END.y + 100:
		queue_free()
