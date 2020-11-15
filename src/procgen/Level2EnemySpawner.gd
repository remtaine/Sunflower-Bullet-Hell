class_name Level2EnemySpawner
extends EnemySpawner

func _ready():
#	thread = Thread.new()
	enemy_spawn_counts = {
		1: [1,0,0,0,0],
		2: [1,1,0,1,0],
		3: [1,1,1,0,0],
		4: [2,1,2,0,1],
		5: [1,2,1,1,2],
		6: [1,1,2,0,2],
		7: [1,0,3,1,1],
		8: [1,1,3,0,2],
		9: [2,1,2,2,3],
		10: [2,2,3,1,4],
	}
	
