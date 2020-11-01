class_name PlayerRespawn
extends State

export (float) var spawn_time = 0.7
func enter():
	var temp = owner
	tween.interpolate_property(temp, "global_position", temp.global_position + Vector2.DOWN * 150, temp.global_position, spawn_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
func _on_tween_completed(_object, key):
	if owner._state == self and key == ":global_position":
		owner.change_state("idle")

func exit():
	GameInfo.current_level.level_start_label_anim.play("ScrollRight")
