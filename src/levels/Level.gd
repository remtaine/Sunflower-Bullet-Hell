class_name Level
extends Node2D

var menu_path = "res://src/menus/MainMenu.tscn"
onready var bullet_server = $BulletServer

func _ready():
	bullet_server.connect("collision_detected",self,"handle_collision")

func _unhandled_input(event):
	if event.is_action_pressed("reset"):
		var _scene = get_tree().reload_current_scene()
	elif event.is_action_pressed("menu"):
		var _scene = get_tree().change_scene(menu_path)

func _process(_delta):
	update_labels()
	
func update_labels():
	$UI/UIControl/Labels/FPS.text = "FPS: " + String(Engine.get_frames_per_second())
	$UI/UIControl/Labels/BulletCount.text = "BULLETS: \n" + String(bullet_server.get_bullet_count())
	
func handle_collision(_bullet, colliders):
	for collider in colliders:
		collider.damage()
