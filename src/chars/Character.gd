extends KinematicBody2D

onready var bullet_spawner = $Addons/BulletSpawner
onready var shot_cooldown_timer = $Timers/ShotCooldown

func _ready():
	pass


func _on_Timer_timeout():
	bullet_spawner.fire()
	#TODO add sfx
	shot_cooldown_timer.start()
