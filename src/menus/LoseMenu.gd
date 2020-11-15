class_name LoseMenu
extends Node2D


func _ready():
	modulate = 0

func activate(_val := true):
#	visible = val
#	$RestartLabel.is_on = val
#	$MenuLabel.is_on = val
	$AnimationPlayer.play("Appear")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
#	$RestartLabel/AnimationPlayer.play("idle")
#	$MenuLabel/AnimationPlayer.play("idle")
	for label in $BlinkingLabels.get_children():
		label.is_on = true
		label.get_node("AnimationPlayer").play("idle")
