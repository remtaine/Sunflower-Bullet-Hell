extends CPUParticles2D

onready var timer = $Timer
	
func setup(pos):
	global_position = pos
	emitting = true
	timer.start()

func _on_Timer_timeout():
	queue_free()
