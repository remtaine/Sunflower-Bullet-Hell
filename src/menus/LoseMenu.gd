class_name LoseMenu
extends Node2D


func _ready():
	pass

func activate(val := true):
	visible = val
	$RestartLabel.is_on = val
	$MenuLabel.is_on = val
