extends ParallaxBackground

onready var layer1 = $BackgroundLayer

func _ready():
	pass

func _process(delta):
	layer1.motion_offset.y += 1
