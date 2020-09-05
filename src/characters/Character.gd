class_name Character
extends KinematicBody2D

var is_flipped : bool = false
var _state = null
var possible_states : Dictionary = {}
onready var sprite = $Pivot/Sprite
onready var bullets_pool = get_parent().get_parent().get_node("BulletPool")
onready var particles_pool = get_parent().get_parent().get_node("ParticlesPool")
onready var states_holder = $States
onready var state_label = $Addons/StateLabel

onready var audio_shoot = $Audio/Shoot
onready var audio_hurt = $Audio/Hurt
onready var audio_bullet_time = $Audio/BulletTime

onready var bullet_cd_timer = $Timers/BulletCD
onready var bullet_spawn_point = $Addons/BulletSpawner
onready var bullet_resource = preload("res://src/bullets/Bullet.tscn")
onready var death_particle = preload("res://src/particles/DeathParticle.tscn")

onready var hurt_anim = $Animations/Hurt
export (String, "player", "enemy", "bird") var character_type = "player"

var collision = null
var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO

var target = null

var default_shot_direction := Vector2.UP
var shoot_style := 1
var hp := 3
var invulnerable = false setget set_invulnerability

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

func change_direction(_dir):
	pass

func damage(dmg := 1) -> void:
	hp -= dmg
	hp = max(0, int(hp))
	if hp == 0:
		die()
	else:
		audio_hurt.play()
		hurt_anim.play("hurt")
		if character_type == "player":
			invulnerable = true
		#TODO do hurt stuff

func die():
	audio_hurt.play()
	var d = death_particle.instance()
	particles_pool.add_child(d)
	d.setup(global_position)
	
	queue_free()
	
func shoot():
	audio_shoot.play()
	
#	bullets_pool.shoot(character_type, bullet_spawn_point.global_position, shoot_style)
#	get_tree().call_group("bullet_pools", "shoot", character_type, bullet_spawn_point.global_position, shoot_style)
#	var bullet
#	match character_type:
#		"enemy":
#
#		"player":
#			match shoot_style:
#				1:
#					#checks bullet pool for free bullet
#					bullet = bullet_resource.instance()
#					bullets_pool.add_child(bullet)
#					#REPLACE THIS ^
#
#					#initializes that
#					bullet.setup(bullet_spawn_point.global_position, default_shot_direction, character_type)
#					#REPLACE THIS ^
#				2:
#					pass 
#
	bullet_cd_timer.start()	

func set_invulnerability(v := true):
	invulnerable = v
