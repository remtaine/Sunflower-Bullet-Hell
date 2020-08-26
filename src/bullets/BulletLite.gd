class_name BulletLite
extends Hitbox

var is_active : bool = false
var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
export var speed = 120
onready var sprite = $Sprite

func _ready():
	deactivate()
	
func setup(pos, dir, ct, spd = speed):
	global_position = pos
	direction = dir
	character_type = ct
	sprite.play(character_type)
	velocity = direction * speed
	#todo add weakref
	activate()

func _process(delta):
	position += velocity * delta
	#TODO add movement

func activate():
	is_active = true
	set_process(is_active)
	
func deactivate():
	is_active = false
	set_process(is_active)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
