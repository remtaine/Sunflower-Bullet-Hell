class_name BlinkingLabel
extends Label

export (String) var next_scene = "res://src/levels/Level1.tscn"
export (float) var scene_change_delay = 1.0
onready var anim = $AnimationPlayer

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("shoot"):
		anim.playback_speed = 10
		yield(get_tree().create_timer(scene_change_delay), "timeout")
		get_tree().change_scene(next_scene)
