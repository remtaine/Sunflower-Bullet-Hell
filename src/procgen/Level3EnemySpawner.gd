class_name Level3EnemySpawner
extends Level1EnemySpawner


func _ready() -> void:
	enemy_spawn_counts = {
		1: [1,1,1,1,1],
		2: [1,2,1,1,2],
		3: [1,2,2,1,1],
		4: [2,1,3,2,1],
		5: [1,2,6,1,2],
		6: [1,1,2,1,2],
		7: [1,2,3,1,1],
		8: [1,1,4,1,2],
		9: [2,1,2,2,3],
		10: [2,2,3,1,4],
	}
