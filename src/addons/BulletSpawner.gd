class_name BulletSpawn
extends BulletSpawner

export (int) var default_bullet_style = -1

onready var anim = $BulletAnimationPlayer

func _ready() -> void:
	pass
#	if default_bullet_style != -1:
#		owner.set_shoot_style(default_bullet_style, self)
#		self.set_autofire(true)
#		print(get_autofire())
