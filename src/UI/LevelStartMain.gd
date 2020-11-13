extends Control


export (float) var animation_speed = 1.0

func _ready() -> void:
	$Label/AnimationPlayer.playback_speed = animation_speed
