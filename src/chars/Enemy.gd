class_name Enemy
extends Character

const ENEMY_BORDER_START = Vector2(120, 40)
const ENEMY_BORDER_END = Vector2(800, 450)

var points_on_death := 5000
signal enemy_died

func _ready():
	var _succesful_connection = connect("enemy_died",level,"update_score")
	
	
func die():
	emit_signal("enemy_died", points_on_death)
	.die()

func shoot():
	if (GameInfo.current_player):
		play_audio("shoot")
		for bullet_spawner in bullet_spawners.get_children():
			bullet_spawner.fire()
