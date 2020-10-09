class_name Particle
extends CPUParticles2D

func _ready():
	self.emitting = true
	$Sound.play()

func _on_Timer_timeout():
	queue_free()
