class_name Level
extends Node2D

var menu_path = "res://src/menus/MainMenu.tscn"

var graze_count := 0
var grazed_bullets := []

var score := 0
var score_displayed := 0
var lives_displayed = 3

var time_start := 0
var time_now := 0
var time_elapsed := 0

var wave_displayed := 0

onready var normal_theme = $Audio/Theme
onready var bullet_theme = $Audio/BulletTheme

onready var bullet_server = $BulletServer
onready var tween = $Addons/Tween
onready var object_holder = $Objects
onready var particle_holder = $Particles

onready var lose_menu = $UI/UIControl/ConditionMenus/LoseMenu

onready var enemy_spawner = $Enemies
onready var level_start_label_anim = $UI/UIControl/LevelStart/Label/AnimationPlayer

onready var bullet_hit_particle = preload("res://src/particles/BulletHitParticle.tscn")

func _ready():
	$UI/UIControl/Labels/Version.text = GlobalInfo.version
	GameInfo.current_level = self
	time_start = OS.get_unix_time()
	bullet_server.connect("collision_detected",self,"handle_collision")
#	lose_menu.activate(false)
#	$Cutscenes/AnimatedSprite.play()
	
func _unhandled_input(event):
	if event.is_action_pressed("reset"):
		var _scene = get_tree().reload_current_scene()
	elif event.is_action_pressed("menu"):
		var _scene = get_tree().change_scene(menu_path)
	pass
	
func _process(_delta):
	time_now = OS.get_unix_time()
	time_elapsed = time_now - time_start
	update_labels()
	
func update_score(additional_points):
	score += additional_points
	var calculated_time :float = min(float(score - score_displayed)/5000.0, 2.5)
	tween.interpolate_property(self, "score_displayed", score_displayed, score, calculated_time, Tween.TRANS_LINEAR, Tween.EASE_IN)		
	tween.start()

func update_labels():
	$UI/UIControl/Labels/FPS.text = "FPS: " + String(Engine.get_frames_per_second())
	$UI/UIControl/Labels/BulletCount.text = "BULLETS: \n" + String(bullet_server.get_live_bullet_count())
	$UI/UIControl/Labels/Lives.text = "LIVES: \n" + lives_to_string()
	if (GameInfo.current_player):
		$UI/UIControl/Labels/Score.text = "SCORE: \n" + String(int(ceil(score_displayed)))
		$UI/UIControl/Labels/Time.text = "TIME " + get_time_string()
		$UI/UIControl/Labels/Wave.text = "WAVE: \n" + String(wave_displayed)
		$UI/UIControl/Labels/Graze.text = "GRAZE: \n" + String(graze_count)
	
func get_time_string() -> String:
	var mins = int(floor(time_elapsed/60.0))
	var secs = time_elapsed % 60
	var additional_zero := ""
	if secs < 10:
		additional_zero = "0"
	return String(mins) + ":" + additional_zero + String(secs)
	
func handle_collision(bullet, colliders): #HANDLES BULLET COLLISION!

	for collider in colliders:
		if collider.get_name() == "Graze":
			if not bullet.get_ci_rid() in grazed_bullets and $Characters/Player.visible:
				grazed_bullets.append(bullet.get_ci_rid())
				graze_count += 1
			continue
		var entity = collider.owner

		if !entity.is_immune:
			create_bullet_particle(bullet.get_position())
			bullet.pop()
			entity.damage(bullet.get_type().get_damage())# * collider.damage_multiplier)
			
	#TODO check if collider is player
	#if so destroy all bullets
	#and respawn player!
func create_bullet_particle(pos : Vector2):
	var particle = bullet_hit_particle.instance()
	particle.position = pos
	particle_holder.add_child(particle)
	
func update_wave():
	wave_displayed += 1

func update_player_lives(new_hp):
	lives_displayed = new_hp
	
	if lives_displayed <= 0: #ie lose
		$UI/UIControl/Labels/Score.text = "SCORE: \n" + String(int(ceil(score)))
		lose_menu.activate()
		bullet_server.clear_bullets()
	else:
		clear_live_bullets()
		
func lives_to_string() -> String:
	var lives = ""
	for _i in range (lives_displayed):
		lives += "O"
	return lives

func clear_live_bullets():
	for bullet_pos in bullet_server.get_live_bullet_positions():
		create_bullet_particle(bullet_pos)
	bullet_server.clear_bullets()
	
func screenshake():
	$Addons/Camera2D/Screenshake.start()

func spawn_coins(num : int, pos: Vector2, sc := 1, explosion_strength := 1, rand := 0.2):
	$Objects/CoinHandler.spawn_coins(num,pos,sc,explosion_strength, rand)
