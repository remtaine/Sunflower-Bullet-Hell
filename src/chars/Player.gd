class_name Player
extends Character

const GAME_BORDER_START = Vector2(220, 40)
const GAME_BORDER_END = Vector2(740, 450)

var is_bullet_time := false

onready var bullet_time_bar = $Addons/Bars/BulletTimeBar
onready var spec_cd_timer = $Timers/SpecCooldown
onready var petals = $SpritePivot/Petals
onready var spec_bullet_spawners = $SpecBulletSpawners
signal player_hurt

func _ready():
	#lets reset!
	Engine.time_scale = 1
	bullet_time_bar.value = 10000
	hp = 3
	var _succesful_connection = connect("player_hurt", level, "update_player_lives")

func _physics_process(_delta):
	position.x = clamp(position.x, GAME_BORDER_START.x, GAME_BORDER_END.x)
	position.y = clamp(position.y, GAME_BORDER_START.y, GAME_BORDER_END.y)

	if Input.is_action_pressed("shoot") and petals.petals_visible > 0:
		if spec_cd_timer.is_stopped():
			shoot_spec()
			petals.use_petal()

func _input(event):
	if event.is_action_pressed("bullet_time"):
		bullet_time()
	

func shoot():
#	play_audio("shoot")
	for bullet_spawner in bullet_spawners.get_children():
#		bullet_spawner.fire()
		pass
		
func shoot_spec():
	play_audio("shoot_spec")	
	for bullet_spawner in spec_bullet_spawners.get_children():
		bullet_spawner.fire()
	spec_cd_timer.start()
	
func get_hurt(_dmg := 1):
	is_immune = true
	set_collision_layer(0)
	emit_signal("player_hurt", hp)
	.get_hurt()

func die():
	emit_signal("player_hurt", hp)
	if bullet_time_bar.visible:
		bullet_time(true)
	.die()
	
func bullet_time(asap := false):
	var slowed_time := 0.3
	var time_shift_duration:= 0.2
	var theme_shift_duration = 0.3
	var normal_volume = -2
	is_bullet_time = !is_bullet_time
	
	play_audio("bullet_time")
	if asap:
		Engine.time_scale = 1.0
		level.normal_theme.volume_db = normal_volume
		level.bullet_theme.volume_db = -80
		
	elif is_bullet_time:
		tween.interpolate_property(Engine, "time_scale", Engine.time_scale, slowed_time, time_shift_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)		
		tween.interpolate_property(self, "speed", speed, normal_speed * 2, time_shift_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)		
		tween.interpolate_property(level.normal_theme, "volume_db", level.normal_theme.volume_db, -80, theme_shift_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.interpolate_property(level.bullet_theme, "volume_db", level.bullet_theme.volume_db, normal_volume, theme_shift_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
		#TODO add audio change as well!
	else:
		tween.interpolate_property(Engine, "time_scale", Engine.time_scale, 1.0, time_shift_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.interpolate_property(self, "speed", speed, normal_speed, time_shift_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)		
		tween.interpolate_property(level.normal_theme, "volume_db", level.normal_theme.volume_db, normal_volume, theme_shift_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.interpolate_property(level.bullet_theme, "volume_db", level.bullet_theme.volume_db, -80, theme_shift_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)		
		#TODO add audio change as well!
		
	bullet_time_bar.visible = is_bullet_time
	tween.start()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hurt":
		is_immune = false
		set_collision_layer(2)

func play_audio(action : String):
	match action:
		"bullet_time":
			$Audio/BulletTime.play()
		"shoot_spec":
			$Audio/ShootSpec.play()
		_:
			.play_audio(action)
