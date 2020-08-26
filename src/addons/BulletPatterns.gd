class_name BulletPatterns
extends Node2D
#Mainly for arranging BulletSpawners

onready var bullet_resource = preload("res://src/bullets/BulletLite.tscn")
onready var objects_holder = get_parent().get_parent().get_parent().get_parent().get_node("ObjectsHolder")

var character_type
func _ready():
	owner = get_parent().get_parent()
	character_type = owner.character_type

func _process(delta):
	rotation_degrees += 2
	
func shoot():
	for i in range (0,get_child_count()):
		var bullet_pos = get_child(i)
		var b = bullet_resource.instance()
		objects_holder.add_child(b)
		#REPLACE THIS ^
		
		#initializes that		
		b.setup(bullet_pos.global_position, (bullet_pos.global_position - global_position).normalized(), owner.character_type)
		#REPLACE THIS ^
		#do CD
