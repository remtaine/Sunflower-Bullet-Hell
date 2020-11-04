extends Sprite

var target
export (bool) var follow_x = true
export (bool) var follow_y = true
export (bool) var stay_in_border = true

var leeway := 40

func _ready() -> void:
	target = get_parent().get_parent().get_parent()
	
func _process(delta: float) -> void:
	if follow_x:
		global_position.x = target.global_position.x
	if follow_y:
		global_position.y = target.global_position.y

	if stay_in_border:
		if global_position.x < GameInfo.GAME_BORDER_START.x - leeway:
			visible = false
		elif global_position.x > GameInfo.GAME_BORDER_END.x + leeway:
			visible = false
		else:
			visible = true
