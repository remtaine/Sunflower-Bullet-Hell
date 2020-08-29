class_name Level
extends Node2D

var menu_path = ""
const AUDIO_NORMAL = -10.0
const AUDIO_MUTED = -80.0

onready var fps_label = $HUD/Labels/FPSLabel
onready var bullets_label = $HUD/Labels/BulletsLabel
onready var wave_label = $HUD/Labels/WaveLabel

onready var audio = $Audio
var audios = []
var selected_audio = 1
var crossfade_duration = 0.2

func _ready():
	add_to_group("levels")
	for sound in audio.get_children():
		audios.append(sound)
	
func _unhandled_input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
	elif event.is_action_pressed("menu"):
		get_tree().change_scene(menu_path)

func _process(delta):
	fps_label.text = "FPS: \n" + String(Engine.get_frames_per_second())
	var bullet_pool = $Characters/BulletPool
	
	bullets_label.text = "Bullets: \n" + String(bullet_pool.get_child_count())#String(bullet_pool.get_child_count() - bullet_pool.free_bullet_pool.size())
	wave_label.text = "Wave: \n" + String($Characters.wave_number)

func set_audio(turn_on : bool, speed = 1):
	var a0 = audio.get_child(0) #ie normal
	var a1 = audio.get_child(1) #ie bullet_time
	if not turn_on:
		a0.get_node("Tween").interpolate_property(a0, "volume_db", a0.volume_db, AUDIO_NORMAL, crossfade_duration * speed,Tween.TRANS_LINEAR,Tween.EASE_IN)
		a1.get_node("Tween").interpolate_property(a1, "volume_db", a1.volume_db, AUDIO_MUTED, crossfade_duration * speed,Tween.TRANS_LINEAR,Tween.EASE_IN)
	else:
		a0.get_node("Tween").interpolate_property(a0, "volume_db", a0.volume_db, AUDIO_MUTED, crossfade_duration * speed,Tween.TRANS_LINEAR,Tween.EASE_IN)
		a1.get_node("Tween").interpolate_property(a1, "volume_db", a1.volume_db, AUDIO_NORMAL, crossfade_duration * speed,Tween.TRANS_LINEAR,Tween.EASE_IN)
	for sound in audio.get_children():
		sound.get_node("Tween").start()
		
