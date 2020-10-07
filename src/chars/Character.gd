class_name Character
extends KinematicBody2D

var _state = null
var possible_states : Dictionary = {}

var velocity : Vector2 = Vector2. ZERO
var direction : Vector2 = Vector2.ZERO

onready var mat = self.material

onready var sprite_pivot = $SpritePivot
onready var sprite = $SpritePivot/Sprite

onready var states_holder = $States

onready var bullet_spawner = $Addons/BulletSpawner
onready var anim = $Addons/AnimationPlayer

onready var shot_cooldown_timer = $Timers/ShotCooldown

func _ready():
	if states_holder != null:
		for child in states_holder.get_children():
			possible_states[child.state_name] = child
			if _state == null:
				_state = child
	print(_state.state_name)

func _physics_process(delta):
	var input = _state.get_raw_input()
	change_state(_state.interpret_inputs(input))
	_state.run(input)

func change_state(state_name, repeat = false):
	var new_state = possible_states[state_name]
	if _state != new_state or repeat:
		print("STATE IS ", state_name)
		_state.exit()
		_state = new_state
		_state.enter()

func _on_Timer_timeout():
	mat.set_shader_param("HIT", true)
	bullet_spawner.fire()
	#TODO add sfx
	shot_cooldown_timer.start()
