class_name BulletLite
extends Hitbox

var velocity := Vector2.ZERO
var direction := Vector2.ZERO
var linear_accel := 0.0
var curve_accel := 0.0
export var speed = 150
onready var sprite = $Sprite
signal deactivated(bullet)

func _ready():
	activate(false)
	connect("deactivated",get_parent(),"return_free_bullet")

func setup(pos, dir, ct, l_accel := 0.0, c_accel := 0.0, spd := speed):
	global_position = pos
	direction = dir
	character_type = ct
	sprite.play(character_type)
	velocity = direction * speed
	linear_accel = l_accel
	curve_accel = c_accel
	activate()

func _process(delta):
	direction = direction.rotated(curve_accel/PI)
	velocity += linear_accel * direction
	position += velocity * delta
	#TODO add movement

func activate(turn_on := true):
	visible = turn_on
	set_process(visible)
	if not turn_on:
		emit_signal("deactivated", self)
#		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
#	activate(false)
