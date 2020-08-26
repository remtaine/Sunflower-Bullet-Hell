class_name Player
extends Character

onready var tween = $Addons/Tween
onready var bullet_resource = preload("res://src/bullets/BulletLite.tscn")

onready var bullet_cd_timer = $Timers/BulletCD
onready var bullet_recharge_timer = $Timers/BulletRecharge
onready var bullet_spawn_point = $Addons/BulletSpawner
var auto_shoot = false
var time_shift_duration = 0.5
var bullets_available = 8
var max_bullets = 8

onready var bounding_rect = get_parent().get_parent().get_node("BG").get_node("Background")
func _ready():
	add_to_group("allies")
	change_direction()
	Engine.time_scale = 1.0
	
func change_direction(dir = "idle"):
	sprite.play(dir)

func _physics_process(delta):
	._physics_process(delta)
	var leeway = 30
	position.x = clamp(position.x, leeway, bounding_rect.margin_right-leeway)
	position.y = clamp(position.y, leeway, bounding_rect.margin_bottom-leeway)
	if Input.is_action_just_pressed("auto_shoot"):
		auto_shoot = not auto_shoot
	if Input.is_action_just_pressed("bullet_time"):
		get_tree().call_group("levels", "set_audio")

		if Engine.time_scale == 1:
			tween.interpolate_property(Engine, "time_scale", Engine.time_scale, 0.2, time_shift_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
		else:
			tween.interpolate_property(Engine, "time_scale", Engine.time_scale, 1.0, time_shift_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.start()
	
	#FOR SHOOTING
	if (_state.inputs.is_shooting or auto_shoot) and bullet_cd_timer.is_stopped() and bullets_available > 0:
		shoot()

func shoot():
	#checks bullet pool for free bullet
		var b = bullet_resource.instance()
		objects_holder.add_child(b)
		#REPLACE THIS ^
		
		#initializes that		
		b.setup(bullet_spawn_point.global_position, Vector2.UP, character_type)
		#REPLACE THIS ^
		bullets_available -= 1
		show_petals(bullets_available)
		#do CD
		bullet_cd_timer.start()
		if bullet_recharge_timer.is_stopped():
			bullet_recharge_timer.start()

func show_petals(n):
#	pass
	var petals = $Pivot/Petals
	for i in range (0, bullets_available):
		petals.get_child(i).visible = true
	for j in range (bullets_available,max_bullets):
		petals.get_child(j).visible = false
		
func _on_BulletRecharge_timeout():
	if bullets_available < max_bullets:
		bullets_available += 1
		show_petals(bullets_available)
		if bullets_available < max_bullets:
			bullet_recharge_timer.start()
