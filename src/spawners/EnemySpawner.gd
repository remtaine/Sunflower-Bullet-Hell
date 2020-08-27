extends Node2D

var wave_number = 0
onready var enemy_resource = preload("res://src/characters/Enemy.tscn")

func _process(delta):
	if get_child_count() == 1 and get_child(0).visible:
		spawn_enemies()

func spawn_enemies():
	wave_number += 1
	
	var num =  1 + floor(wave_number/3)
	randomize()
	for i in range (num):
		var x = randi() % 450 + 50
		var y = randi() % 100 - 150 #-150 to -50 is like 0 to 100 - 150
		var enemy = enemy_resource.instance()
		add_child(enemy)
		enemy.setup(Vector2(x,y), Vector2(0, 250))
