class_name Character
extends KinematicBody2D

var is_flipped : bool = false
var _state = null
var possible_states : Dictionary = {}
onready var sprite = $Pivot/Sprite
onready var objects_holder = get_parent().get_parent().get_node("ObjectsHolder")
onready var states_holder = $States
onready var state_label = $Addons/StateLabel
onready var stats = $Stat

onready var death_particle = preload("res://src/particles/DeathParticle.tscn")
export var character_type = "player"
var collision = null
var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO

func _ready():
	if states_holder != null:
		for child in states_holder.get_children():
			possible_states[child.state_name] = child
			if _state == null:
				_state = child
#	if $Addons.has_node("Hitbox"):
#		var hitbox = $Addons.get_node("Hitbox")
#		hitbox.setup()
##		hitbox.get_node("CollisionShape2D").disabled = false
#	if $Addons.has_node("Hurtbox"):
#		var hurtbox = $Addons.get_node("Hurtbox")
#		hurtbox.setup()
#		hurtbox.get_node("CollisionShape2D").disabled = false
		
		
func _physics_process(delta):
	var input = _state.get_raw_input()
	change_state(_state.interpret_inputs(input))
	_state.run(input)
	collision = move_and_collide(velocity * delta)
	state_label.text = _state.state_name
		
func change_state(state_name, repeat = false):
	var new_state = possible_states[state_name]
	if _state != new_state or repeat:
		exit_state()
		_state = new_state
		enter_state()
	
func enter_state():
	_state.enter()
	
func exit_state():
	_state.exit()

func change_direction(dir):
	pass

func damage(dmg = 1):
#	if stats.update("health", dmg):
	die()
#	else:
#		pass
		#TODO do hurt stuff
		
func die():
	var d = death_particle.instance()
	objects_holder.add_child(d)
	d.setup(global_position)
	
	queue_free()

func get_stat(stat_name):
	return stats.get(stat_name)

func update_stat(stat_name):
	return stats.get(stat_name)
