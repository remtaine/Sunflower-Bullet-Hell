class_name SplashScreen
extends Control

export (bool) var skip_scene = false
export (String) var next_scene

onready var names = $Names
var current_name := 0
var names_array = []

func _ready() -> void:
	if skip_scene:
		var _scene_change_status = get_tree().change_scene(next_scene)
	else:
		for name in names.get_children():
			name.get_node("AnimationPlayer").connect("animation_finished", self, "next_name")
			names_array.append(name)
		names_array[current_name].get_node("AnimationPlayer").play("Appear")	
#	play_name(current_name)

func next_name(_anim_name : String):
	if current_name < names.get_child_count() - 1:
		current_name += 1
		names_array[current_name].get_node("AnimationPlayer").play("Appear")
	else:
		var _scene_change_status = get_tree().change_scene(next_scene)
		#TODO GO TO NAMIN MENU
		
