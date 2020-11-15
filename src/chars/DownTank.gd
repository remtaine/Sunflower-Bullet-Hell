class_name DownTank
extends DownBird

func _ready() -> void:
	set_shoot_style(0, $BulletSpawners/BulletSpawner, 3)
	$BulletSpawners/BulletSpawner.set_autofire(true)

func _physics_process(_delta):
	look_at(GameInfo.current_player.global_position)
