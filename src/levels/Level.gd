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
func set_audio():
	for sound in audio.get_children():
		if audio.get_child(selected_audio).stream == sound.stream:
			sound.get_node("Tween").interpolate_property(sound, "volume_db", sound.volume_db, 0.0, crossfade_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
		else:
			sound.get_node("Tween").interpolate_property(sound, "volume_db", sound.volume_db, -80.0, crossfade_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
		print("AUDIO NOW AT ", sound.volume_db)
	for sound in audio.get_children():
		sound.get_node("Tween").start()	
	selected_audio += 1
	selected_audio = selected_audio % audio.get_child_count()
