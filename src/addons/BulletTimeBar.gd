class_name BulletTimeBar
extends TextureProgress


func _ready():
	owner = get_parent().get_parent().get_parent()

func _process(_delta):
	if visible:
		value -= 3;
	else:
		value += 1;
	
	if value == 0 and owner.visible:
		owner.bullet_time()
