class_name Level
extends Node2D

var menu_path = ""
onready var bullet_server = $BulletServer

func _ready():
	pass

func _unhandled_input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
	elif event.is_action_pressed("menu"):
		get_tree().change_scene(menu_path)

func _process(delta):
	update_labels()
	
func update_labels():
	$UI/UIControl/Labels/FPS.text = "FPS: " + String(Engine.get_frames_per_second())
	$UI/UIControl/Labels/BulletCount.text = "BULLETS: \n" + String(bullet_server.get_bullet_count())
	
