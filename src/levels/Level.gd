class_name Level
extends Node2D

var menu_path = ""
onready var fps_label = $HUD/Labels/FPSLabel
onready var bullets_label = $HUD/Labels/BulletsLabel

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
	bullets_label.text = "Bullets: \n" + String($ObjectsHolder.get_child_count())
	for sound in audio.get_children():
		print(sound.name + " " , sound.volume_db)
func set_audio(turn_on : bool, speed = 1):
	var a0 = audio.get_child(0) #ie normal
	var a1 = audio.get_child(1) #ie bullet_time
	if not turn_on:
		a0.get_node("Tween").interpolate_property(a0, "volume_db", a0.volume_db, 0.0, crossfade_duration * speed,Tween.TRANS_LINEAR,Tween.EASE_IN)
		a1.get_node("Tween").interpolate_property(a1, "volume_db", a1.volume_db, -80.0, crossfade_duration * speed,Tween.TRANS_LINEAR,Tween.EASE_IN)
	else:
		a0.get_node("Tween").interpolate_property(a0, "volume_db", a0.volume_db, -80.0, crossfade_duration * speed,Tween.TRANS_LINEAR,Tween.EASE_IN)
		a1.get_node("Tween").interpolate_property(a1, "volume_db", a1.volume_db, -00.0, crossfade_duration * speed,Tween.TRANS_LINEAR,Tween.EASE_IN)
		print("lezgo")
	for sound in audio.get_children():
		sound.get_node("Tween").start()
		print("waat")
		
