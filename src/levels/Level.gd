class_name Level
extends Node2D

var menu_path = "res://src/menus/MainMenu.tscn"

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

func _ready():
	time_start = OS.get_unix_time()
	bullet_server.connect("collision_detected",self,"handle_collision")
	
func _unhandled_input(event):
	if event.is_action_pressed("reset"):
		var _scene = get_tree().reload_current_scene()
	elif event.is_action_pressed("menu"):
		var _scene = get_tree().change_scene(menu_path)

func _process(_delta):
	time_now = OS.get_unix_time()
	time_elapsed = time_now - time_start
	update_labels()
	
func update_score(additional_points):
	score += additional_points
	var calculated_time :float = float(score - score_displayed)/2500.0
	tween.interpolate_property(self, "score_displayed", score_displayed, score, calculated_time, Tween.TRANS_LINEAR, Tween.EASE_IN)		
	tween.start()

func update_labels():
	$UI/UIControl/Labels/FPS.text = "FPS: " + String(Engine.get_frames_per_second())
	$UI/UIControl/Labels/BulletCount.text = "BULLETS: \n" + String(bullet_server.get_bullet_count())
	$UI/UIControl/Labels/Score.text = "SCORE: \n" + String(score_displayed)
	$UI/UIControl/Labels/Lives.text = "LIVES: \n" + lives_to_string()
	$UI/UIControl/Labels/Time.text = "TIME " + get_time_string()
	$UI/UIControl/Labels/Wave.text = "WAVE: \n" + String(wave_displayed)
	
func get_time_string() -> String:
	var mins = int(floor(time_elapsed/60.0))
	var secs = time_elapsed % 60
	var additional_zero := ""
	if secs < 10:
		additional_zero = "0"
	return String(mins) + ":" + additional_zero + String(secs)
	
func handle_collision(bullet, colliders):
	bullet.pop()
	for collider in colliders:
		collider.damage(bullet.get_type().get_damage())

func update_wave():
	wave_displayed += 1

func update_player_lives(new_hp):
	lives_displayed = new_hp

func lives_to_string() -> String:
	var lives = ""
	for _i in range (lives_displayed):
		lives += "O"
	return lives
