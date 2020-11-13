class_name WinMenu
extends LoseMenu


func _ready():
	modulate = 0

func activate(val := true):
#	visible = val
#	$RestartLabel.is_on = val
#	$MenuLabel.is_on = val
	$ScoreLabel.text = "SCORE: " + String(GameInfo.last_score)
	.activate(val)

#func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
##	$RestartLabel/AnimationPlayer.play("idle")
##	$MenuLabel/AnimationPlayer.play("idle")
#	for label in $BlinkingLabels.get_children():
#		label.is_on = true
#		label.get_node("AnimationPlayer").play("idle")
