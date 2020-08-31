class_name Player
extends Character

onready var tween = $Addons/Tween

onready var bullet_recharge_timer = $Timers/BulletRecharge
onready var bullet_time_bar = $Pivot/ChargeBar

var can_shoot := false setget can_shoot
var slowed_down_time = 0.2
var auto_shoot = false
var time_shift_duration = 0.5
var bullets_left = 8 setget set_bullets_left
var max_bullets = 8
var is_bullet_time = false

onready var bounding_rect = get_parent().get_parent().get_node("BG").get_node("Background")


func _ready():
	GameInfo.current_player = self	
	add_to_group("allies")
	change_direction()
	Engine.time_scale = 1.0
	bullet_time_bar.visible = is_bullet_time

func change_direction(dir = "idle"):
	sprite.play(dir)

func _physics_process(delta):
	._physics_process(delta)
	if is_bullet_time:
		bullet_time_bar.value -= 2
		if bullet_time_bar.value <= 0:
			bullet_time_bar.value = 0
			bullet_time(false)
	else:
		bullet_time_bar.value += 1
	var leeway = 30
	position.x = clamp(position.x, leeway, GameInfo.level_borders.end.x - leeway)
	position.y = clamp(position.y, leeway, GameInfo.level_borders.end.y - leeway)
	if Input.is_action_just_pressed("auto_shoot"):
		auto_shoot = not auto_shoot
	if Input.is_action_just_pressed("bullet_time"):
		bullet_time(Engine.time_scale == 1 and bullet_time_bar.value > 0)
	
	#FOR SHOOTING
	if (_state.inputs.is_shooting or auto_shoot) and can_shoot and bullet_cd_timer.is_stopped() and bullets_left > 0:
		shoot()
#		$Addons/BulletPatterns.shoot()

func shoot():
	#checks bullet pool for free bullet
		.shoot()
		var bullet
		match shoot_style:
				1: #boring shoot
					bullet = bullet_resource.instance()
					bullets_pool.add_child(bullet)
					bullet.setup(bullet_spawn_point.global_position, default_shot_direction, character_type)
#				2: #linear lockon
#					bullet = bullet_resource.instance()
#					bullets_pool.add_child(bullet)
#					bullet.setup(bullet_spawn_point.global_position, default_shot_direction, character_type) 
		
		set_bullets_left()
		if bullet_recharge_timer.is_stopped():
			bullet_recharge_timer.start()

func bullet_time(is_on : bool, speed : float = 1.0):
	audio_bullet_time.play()
	get_tree().call_group("levels", "set_audio", is_on, speed)
	if is_on:
		tween.interpolate_property(Engine, "time_scale", Engine.time_scale, slowed_down_time, time_shift_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
		is_bullet_time = true
	else:
		tween.interpolate_property(Engine, "time_scale", Engine.time_scale, 1.0, time_shift_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
		is_bullet_time = false
	bullet_time_bar.visible = is_bullet_time
	tween.start()

func die():
	if visible:
#		audio_hurt.play()
		if is_bullet_time:
			bullet_time(false, 0.1)
		var d = death_particle.instance()
		particles_pool.add_child(d)
		d.setup(global_position)
		set_physics_process(false)
		visible = false	
		$Addons/Hurtbox.monitorable = false

func can_shoot(c : bool):
	can_shoot = c

func set_bullets_left(val := -1):
	bullets_left += val
	bullets_left = max(0, bullets_left)
	show_petals(bullets_left)
	
func show_petals(n):
#	pass
	var petals = $Pivot/Petals
	for i in range (0, bullets_left):
		petals.get_child(i).visible = true
	for j in range (bullets_left,max_bullets):
		petals.get_child(j).visible = false
		
func _on_BulletRecharge_timeout():
	if bullets_left < max_bullets:
		bullets_left += 1
		show_petals(bullets_left)
		if bullets_left < max_bullets:
			bullet_recharge_timer.start()
