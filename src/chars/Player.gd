class_name Player
extends Character

const GAME_BORDER_START = Vector2(220, 40)
const GAME_BORDER_END = Vector2(740, 450)

func _physics_process(_delta):
	position.x = clamp(position.x, GAME_BORDER_START.x, GAME_BORDER_END.x)
	position.y = clamp(position.y, GAME_BORDER_START.y, GAME_BORDER_END.y)
	#TODO check shot!
	#TODO check bullettime!
