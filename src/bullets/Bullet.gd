class_name Bullet
extends Character

var speed = 0
var owner_type

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	character_type = "bullet"

func setup(pos, dir, ct, spd = speed):
	global_position = pos
	direction = dir
	owner_type = ct
	sprite.play(owner_type)
	velocity = direction * speed
	#todo add weakref
	set_physics_process(true)

func _physics_process(delta):
	._physics_process(delta)
#	if collision:
#		var body = collision.get_collider()
#		if body.character_type == "enemy" and owner_type == "player":
#			collision.get_collider().queue_free()
#			queue_free()
#		elif body.character_type == "player" and owner_type == "enemy":
#			collision.get_collider().queue_free()
#			queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
