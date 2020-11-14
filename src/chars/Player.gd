class_name Player
extends Character

#const GAME_BORDER_START = Vector2(220, 40)
#const GAME_BORDER_END = Vector2(740, 450)

var is_bullet_time := false
var has_won := false

onready var bullet_time_bar = $Addons/Bars/BulletTimeBar
onready var spec_cd_timer = $Timers/SpecCooldown
onready var petals = $SpritePivot/Petals
onready var spec_bullet_spawners = $SpecBulletSpawners
onready var hitbox_sprite = $SpritePivot/HitboxSprite

onready var theme = GameInfo.current_level.get_node("Audio/Theme")
onready var bullet_theme = GameInfo.current_level.get_node("Audio/BulletTheme")

signal player_hurt

func _init():
	GameInfo.current_player = self
	
func _ready():
	
	death_particle = preload("res://src/particles/PlayerDeathParticle.tscn")
	Engine.time_scale = 1
	bullet_time_bar.value = 10000
	var _succesful_connection = connect("player_hurt", level, "update_player_lives")

func _physics_process(_delta):
	if Input.is_action_pressed("shoot") and petals.petals_visible > 0:
		if spec_cd_timer.is_stopped():
			shoot_spec()
			petals.use_petal()

func _input(event):
	if event.is_action_pressed("bullet_time"):
		bullet_time()
	

func shoot():
##	play_audio("shoot")
#	for bullet_spawner in bullet_spawners.get_children():
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

func damage(dmg :=1):
	GameInfo.current_level.screenshake()
	.damage(dmg)

func die():
#	GameInfo.current_player = null
	emit_signal("player_hurt", hp)
	if bullet_time_bar.visible:
		bullet_time(true)
#	.die()
	visible = false
	$SpritePivot/Hitboxes/Hitbox.resistant = true
	$Addons/FlowerStem/FlowerStemTrail.visible = false
	is_immune = true
	var new_death_particle = death_particle.instance()
	new_death_particle.position = position
	particle_holder.add_child(new_death_particle)
	theme.stop()
	bullet_theme.stop()
	set_physics_process(false)
	
func bullet_time(asap := false):
	var slowed_time := 0.3
	var time_shift_duration:= 0.3
	var theme_shift_duration = 0.3
	var normal_volume = -2
	var speed_multiplier = 3
	is_bullet_time = !is_bullet_time
	
	
	if asap:
		play_audio("leave_bullet_time")
		Engine.time_scale = 1.0
		theme.volume_db = normal_volume
		bullet_theme.volume_db = -80
		
	elif is_bullet_time:
		play_audio("enter_bullet_time")
		tween.interpolate_property(Engine, "time_scale", Engine.time_scale, slowed_time, time_shift_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)		
		tween.interpolate_property(self, "speed", speed, normal_speed * speed_multiplier, time_shift_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)		
		tween.interpolate_property(theme, "volume_db", theme.volume_db, -80, theme_shift_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.interpolate_property(bullet_theme, "volume_db", bullet_theme.volume_db, normal_volume, theme_shift_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
		#TODO add audio change as well!
	else:
		play_audio("leave_bullet_time")
		tween.interpolate_property(Engine, "time_scale", Engine.time_scale, 1.0, time_shift_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.interpolate_property(self, "speed", speed, normal_speed, time_shift_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)		
		tween.interpolate_property(theme, "volume_db", theme.volume_db, normal_volume, theme_shift_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.interpolate_property(bullet_theme, "volume_db", bullet_theme.volume_db, -80, theme_shift_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)		
		#TODO add audio change as well!
		
	bullet_time_bar.visible = is_bullet_time
	tween.start()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hurt":
		is_immune = false
		set_collision_layer(2)

func play_audio(action : String):
	match action:
		"enter_bullet_time":
			$Audio/EnterBulletTime.play()
		"leave_bullet_time":
			$Audio/LeaveBulletTime.play()
		"shoot_spec":
			$Audio/ShootSpec.play()
		_:
			.play_audio(action)
