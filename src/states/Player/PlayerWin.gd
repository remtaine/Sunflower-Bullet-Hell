class_name PlayerWin
extends State

export (float) var spawn_time = 1.0
var win_up_dist := 700

func _ready():
	pass
	
func run(_input):
	pass

func enter():
	owner.has_won = true
	GameInfo.last_score = int(GameInfo.current_level.score)
	tween.interpolate_property(owner, "global_position", owner.global_position, owner.global_position + Vector2.UP * win_up_dist, spawn_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
func _on_tween_completed(_object, key):
	if owner._state == self and key == ":global_position":
		#owner.change_state("Idle")
#		owner.visible = false
		#Trigger win menu
		GameInfo.current_level.activate_win_menu()

func exit():
	if (GameInfo.current_level):
		pass
#		GameInfo.current_level.play_cutscene()
#		GameInfo.current_level.level_start_label_anim.play("ScrollRight")
