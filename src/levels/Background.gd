extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var orig_pos : Vector2
var orig_size : Vector2
var orig_scale : Vector2
var scroll_speed := 2
# Called when the node enters the scene tree for the first time.

func _ready():
	pass
#	orig_pos = position
#	orig_size = 
#	orig_scale = scale

func _process(delta):
#	pass
	rect_position.y += scroll_speed
	if  rect_position.y - orig_pos.y >= orig_size.y * orig_scale.y:
		rect_position.y -= (rect_position.y - orig_pos.y)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
