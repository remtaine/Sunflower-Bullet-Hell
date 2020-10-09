class_name EnemySpawner
extends Node2D

var wave_number := 0

onready var standard_bird_resource = preload("res://src/chars/StandardBird.tscn")
onready var sideways_bird_resource = preload("res://src/chars/SidewaysBird.tscn")
onready var level = get_parent()
onready var wave_timer = get_parent().get_node("Timers/Wave")

var ready_to_summon = true
signal wave_cleared

func _ready():
	connect("wave_cleared", level, "update_wave")
	#set_process(false) TODO add wave clear after
	
func _process(_delta):
	if get_child_count() == 0 and ready_to_summon:
		create_new_wave()

func create_new_wave():
	ready_to_summon = false
	emit_signal("wave_cleared")
	yield(get_tree().create_timer(1.0), "timeout")
	spawn_enemies()
	wave_timer.start()
	
func spawn_enemies():
	ready_to_summon = true
	wave_number += 1
	
	var num =  1 + floor(wave_number/3)
	
#	randomize()
	for i in range (num):
		var enemy
		match (randi() % 5):
			0,1,2,3:

				enemy = standard_bird_resource.instance()
				add_child(enemy)

				var x = 250 + randi() % 425
				var y = randi() % 100 - 150 #-150 to -50 is like 0 to 100 - 150
#				randomize()
				var shoot_style = ((randi() % 3 + wave_number/2) % 12) + 1
				enemy.setup(Vector2(x, y), Vector2(x, y + 200), shoot_style)
				print("ENEMY AT ", Vector2(x, y), " WITH GOAL OF ", Vector2(x, y + 250))

			4: #BIRD
				enemy = sideways_bird_resource.instance()
				add_child(enemy)

				var x
				var y = 100 + randi() % 60
				var planned_dir
				
				match randi() % 2:
					0: #going right!
						x = 80 + randi() % 50#-150 to -50 is like 0 to 100 - 150
						planned_dir = Vector2.RIGHT
					1: #going left!
						x = 850 + randi() % 50#-150 to -50 is like 0 to 100 - 150
						planned_dir = Vector2.LEFT
						
				enemy.setup(Vector2(x,y), planned_dir)
#				print("ENEMY AT ", Vector2(x,y), " WITH DIR OF ", planned_dir)
		yield(get_tree().create_timer(0.5), "timeout")

func _on_Wave_timeout():
	create_new_wave()
