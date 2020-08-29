class_name BulletPool
extends Node2D

var free_bullet_pool : Array = []
onready var bullet_resource : PackedScene = preload("res://src/bullets/BulletLite.tscn")

var thread : Thread

func _ready():
	#multithread this?
	add_to_group("bullet_pools")
	create_bullets(500)
#	thread = Thread.new()
#	thread.start(self, "create_bullets")

func create_bullets(num := 1000):
	for i in range (num):
		var bullet = bullet_resource.instance()
		add_child(bullet)
		free_bullet_pool.push_back(bullet)

func shoot(character_type : String, pos : Vector2, style : int, num := 0, clock := 0):
	var bullet
	match character_type:
		"enemy":
			match style:
				0: #normal boring shooting
					bullet = free_bullet_pool.pop_front()
					add_child(bullet)
					bullet.setup(pos, Vector2.DOWN, character_type)
				1:
					for i in range (num):
						bullet = free_bullet_pool.pop_front()
						add_child(bullet)
						bullet.setup(pos, Vector2.DOWN, character_type)
		"player":
			match style:
				0:
					bullet = free_bullet_pool.pop_front()
					add_child(bullet)
					bullet.setup(pos, Vector2.UP, character_type)
				1:
					for i in range (num):
						bullet = free_bullet_pool.pop_front()
						add_child(bullet)
						bullet.setup(pos, Vector2.UP, character_type)
	print("FREE BULLETS now at ", free_bullet_pool.size())
	

func return_free_bullet(bullet):
	free_bullet_pool.push_back(bullet)
	print("BULLET RETURNED, now at ", free_bullet_pool.size())
