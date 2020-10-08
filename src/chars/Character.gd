class_name Character
extends KinematicBody2D

var _state = null
var possible_states := {}

var velocity := Vector2.ZERO
var direction := Vector2.ZERO
export (int) var hp := 100

#sprites
onready var sprite_pivot = $SpritePivot
onready var sprite = $SpritePivot/Sprite

#states
onready var states_holder = $States

#addons
onready var bullet_spawners = $Addons/BulletSpawners
onready var anim = $Addons/AnimationPlayer
onready var tween = $Addons/Tween

#timers
onready var shot_cooldown_timer = $Timers/ShotCooldown

#audio
onready var audio_shoot = $Audio/Shoot
onready var audio_move = $Audio/Move
onready var audio_hurt = $Audio/Hurt

#particles
onready var death_particle = preload("res://src/particles/DeathParticle.tscn")

#outside
onready var objects_holder = get_parent().get_parent().get_node("Objects")

func _ready():
	for bullet_spawner in bullet_spawners.get_children():
		bullet_spawner.bullet_type.rotation = 0
		
	if states_holder != null:
		for child in states_holder.get_children():
			possible_states[child.state_name] = child
			if _state == null:
				_state = child
	print(_state.state_name)

func _physics_process(_delta):
	var input = _state.get_raw_input()
	change_state(_state.interpret_inputs(input))
	_state.run(input)

func damage(dmg := 1):
	hp -= dmg
	hp = int(max(0, hp))
	if hp == 0:
		die()
	else:
		get_hurt()

func die():
	#TODO add death particles
	var new_death_particle = death_particle.instance()
	new_death_particle.position = position
	objects_holder.add_child(new_death_particle)
	queue_free()
	
func get_hurt():
	anim.play("hurt")
	pass

func change_state(state_name, repeat = false):
	var new_state = possible_states[state_name]
	if _state != new_state or repeat:
		_state.exit()
		_state = new_state
		_state.enter()

func shoot():
	for bullet_spawner in bullet_spawners.get_children():
		bullet_spawner.fire()
	#TODO add sfx
	
func _on_Timer_timeout():
	shoot()
	shot_cooldown_timer.start()
