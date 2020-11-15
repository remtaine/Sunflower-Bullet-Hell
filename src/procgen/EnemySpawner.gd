class_name EnemySpawner
extends Node2D

onready var standard_bird_resource = preload("res://src/chars/StandardBird.tscn")
onready var sideways_bird_resource = preload("res://src/chars/SidewaysBird.tscn")
onready var down_bird_resource = preload("res://src/chars/DownBird.tscn")
onready var down_ship_resource = preload("res://src/chars/DownShip.tscn")
onready var standard_ship_resource = preload("res://src/chars/StandardShip.tscn")

var wave_number := 0

onready var level = get_parent()
onready var player_holder = get_parent().get_node("Characters")
onready var wave_timer = get_parent().get_node("Timers/Wave")

var enemy_spawn_counts = {}

export (String) var boss_path = "res://src/chars/Boss1.tscn"
var boss_resource
export (int) var waves_before_boss = 10

var spawn_tries := 0
var enemy_pos := []
var thread
var ready_to_summon = true
var start_summon_boss = false

signal wave_cleared

func _ready():
#	thread = Thread.new()	
	boss_resource = load(boss_path)
	var _connect_status = connect("wave_cleared", level, "update_wave")
	#set_process(false) TODO add wave clear after
	set_process(false)

func _process(_delta):
	if get_child_count() == 0 and ready_to_summon:# and player_holder.get_child_count() == 1:
		
		if wave_number < waves_before_boss:
			create_new_wave()
		elif !start_summon_boss:
			start_summon_boss = true
			GameInfo.current_level.warning_label_anim.play("ScrollRight")
			#summon_boss()

func summon_boss():
	var boss = boss_resource.instance()
	boss.global_position = Vector2(490,-125)
	add_child(boss)
	
func create_new_wave():
	if player_holder.get_child_count() != 1:
		return
	ready_to_summon = false
	emit_signal("wave_cleared")
	yield(get_tree().create_timer(1.5), "timeout")
	
	spawn_enemies()
	wave_timer.start()
	
func spawn_enemies():
	wave_number += 1
	
	var num =  1 + floor(wave_number/3)
	
#	randomize()
#	thread.start(self, "create_enemies", num)
	create_enemies(num)
#	yield(get_tree().create_timer(0.5), "timeout")

func create_enemies(_num: int):
	for _j in range (1):
		var enemy
		
		var current_spawn_counts = enemy_spawn_counts[wave_number]
		
		enemy_pos = []
		spawn_tries = 0
		for _i in range (current_spawn_counts[0]): #standard enemy
			enemy = standard_bird_resource.instance()
			add_child(enemy)
			
			var x = -1
			var y = -1
			while overlapping_previous_enemies(x,y):
				x = 250 + randi() % 425
				y = randi() % 100 - 150 #-150 to -50 is like 0 to 100 - 150
				spawn_tries += 1
			
			enemy_pos.append(Vector2(x,y))
			
			var shoot_style
			randomize()
			if wave_number < 11:
				shoot_style = (randi() % wave_number) + 1
			else:
				shoot_style = (randi() % 11) + 1
			enemy.setup(Vector2(x, y), Vector2(x, y + 200), shoot_style)
			yield(get_tree().create_timer(0.5), "timeout")
		
		spawn_tries = 0
		enemy_pos = []
		for _i in range (current_spawn_counts[1]): #sideways enemy
			enemy = sideways_bird_resource.instance()
			add_child(enemy)

			var x = -1
			var y = -1
			var planned_dir
			while overlapping_previous_enemies(x,y):
				spawn_tries += 1
				y = 100 + randi() % 60
				match randi() % 2:
					0: #going right!
						x = 80 + randi() % 50#-150 to -50 is like 0 to 100 - 150
						planned_dir = Vector2.RIGHT
					1: #going left!
						x = 850 + randi() % 50#-150 to -50 is like 0 to 100 - 150
						planned_dir = Vector2.LEFT
			enemy_pos.append(Vector2(x,y))
			enemy.setup(Vector2(x,y), planned_dir)
			yield(get_tree().create_timer(0.5), "timeout")
			
		spawn_tries = 0
		enemy_pos = []
		for _i in range (current_spawn_counts[2]): #down enemy
			enemy = down_bird_resource.instance()
			add_child(enemy)

			var x = -1
			var y = -1
			
			while overlapping_previous_enemies(x,y):
				spawn_tries += 1
				
				match randi() % 2:
					1:
						x = 500 + randi() % 250
					0:
						x = 500 - randi() % 250
				y = -80 + randi() % 50 #-150 to -50 is like 0 to 100 - 150
			enemy_pos.append(Vector2(x,y))
			enemy.setup(Vector2(x,y))
			yield(get_tree().create_timer(0.5), "timeout")
		
		enemy_pos = []
		spawn_tries = 0
		for _i in range (current_spawn_counts[3]): #standard ship
			enemy = standard_ship_resource.instance()
			add_child(enemy)
			
			var x = -1
			var y = -1
			while overlapping_previous_enemies(x,y):
				x = 250 + randi() % 425
				y = randi() % 100 - 150 #-150 to -50 is like 0 to 100 - 150
				spawn_tries += 1
			
			enemy_pos.append(Vector2(x,y))
			
			var shoot_style = 0
			randomize()
			if wave_number < 11:
				shoot_style = 3#(randi() % wave_number) + 1
			else:
				shoot_style = (randi() % 11) + 1
			enemy.setup(Vector2(x, y), shoot_style, 6)
			yield(get_tree().create_timer(0.5), "timeout")
		
		for _i in range (current_spawn_counts[4]): #down ship
			enemy = down_ship_resource.instance()
			add_child(enemy)

			var x = -1
			var y = -1
			
			while overlapping_previous_enemies(x,y):
				spawn_tries += 1
				
				match randi() % 2:
					1:
						x = 500 + randi() % 250
					0:
						x = 500 - randi() % 250
				y = -80 + randi() % 50 #-150 to -50 is like 0 to 100 - 150
			enemy_pos.append(Vector2(x,y))
			enemy.setup(Vector2(x,y),Vector2(x,y + 200))
			yield(get_tree().create_timer(0.5), "timeout")
		
	ready_to_summon = true


func overlapping_previous_enemies(x : float,y : float, dist := 100):
	if x == -1 and y == -1:
		return true
	elif spawn_tries >= 10:
		return false
		
	for pos in enemy_pos:
		if pos.distance_to(Vector2(x,y)) < dist:
			return true
			
	return false
	
func _on_Wave_timeout():
	if wave_number >= waves_before_boss:
		return
		
	if ready_to_summon:
		create_new_wave()
	else:
		wave_timer.start()
#
#func _exit_tree():
#	thread.wait_to_finish(j)
