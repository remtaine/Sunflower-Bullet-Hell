class_name Stats
extends Node


func get(stat_name : String):
	return int((get_node(stat_name.capitalize()).value))

func update(stat_name : String, val):
	return get_node(stat_name.capitalize()).update(val)
