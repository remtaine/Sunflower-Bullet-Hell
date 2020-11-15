class_name DownShip
extends DownBird

func setup(pos, gp = Vector2.ZERO):
	position = pos
	waypoints.append(gp)
	
func _ready() -> void:
	pass
