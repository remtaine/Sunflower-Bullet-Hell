class_name PlayerWin
extends State

export (float) var spawn_time = 0.8


func _ready():
	pass
	
func run(input):
	pass

func enter():
	owner.has_won = true
	GameInfo.last_score = int(GameInfo.current_level.score)
	tween.interpolate_property(owner, "global_position", owner.global_position, owner.global_position + Vector2.UP * 500, spawn_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
func _on_tween_completed(_object, key):
	if owner._state == self and key == ":global_position":
		#owner.change_state("Idle")
#		owner.visible = false
		GameInfo.current_level.win_menu.activate()
		#Trigger win menu

func exit():
	if (GameInfo.current_level):
		pass
#		GameInfo.current_level.play_cutscene()
#		GameInfo.current_level.level_start_label_anim.play("ScrollRight")
