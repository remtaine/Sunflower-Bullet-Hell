class_name Level1EnemySpawner
extends EnemySpawner

func _ready():
#	thread = Thread.new()
	enemy_spawn_counts = {
		1: [1,0,0,0,0],
		2: [1,1,0,0,0],
		3: [1,1,1,0,0],
		4: [2,1,2,0,0],
		5: [2,1,3,0,0],
		6: [1,2,5,0,0],
		7: [2,0,3,0,0],
		8: [1,1,6,0,0],
		9: [3,1,4,0,0],
		10: [2,2,8,0,0],
	}
