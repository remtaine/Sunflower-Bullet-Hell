class_name Boss2
extends Boss1

onready var tank_resource = preload("res://src/chars/DownTank.tscn")
#TODO change death

func _on_TankSpawn_timeout() -> void:
	summon_tank()

func summon_tank():
	var tank = tank_resource.instance()
	tank.global_position = global_position + (Vector2.DOWN * 100)
	GameInfo.current_level.get_node("Enemies").add_child(tank)
