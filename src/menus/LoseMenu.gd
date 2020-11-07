class_name LoseMenu
extends Node2D


func _ready():
	modulate = 0

func activate(val := true):
#	visible = val
#	$RestartLabel.is_on = val
#	$MenuLabel.is_on = val
	$AnimationPlayer.play("Appear")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	$RestartLabel/AnimationPlayer.play("idle")
	$MenuLabel/AnimationPlayer.play("idle")
