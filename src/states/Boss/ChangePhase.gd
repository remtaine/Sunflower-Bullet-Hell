class_name ChangePhase
extends State

var color_change := 0.09
func _ready():
	pass
	
func run(_input):
	pass

func enter():
	GameInfo.current_level.spawn_coins_on_bullets()
	var m = owner.sprite.modulate
	owner.sprite.modulate = Color(m.r,m.g - color_change * owner.phase, m.b - color_change * owner.phase)
	for timer in owner.timers.get_children():
		timer.stop()
		
	owner.phase += 1
	
	owner.health_multiplier.text = "X" + String(owner.phase_count - owner.phase)
	print(owner.phase_count, " DDDD ", owner.phase)
	owner.health_bar.value = owner.phase_hp
	owner.current_phase_hp = owner.phase_hp
	
	print("PAHSE IS NOW ", owner.phase)
	owner.change_state("GetInPosition")
	
func exit():
	GameInfo.current_level.spawn_coins(owner.coin_count, owner.global_position)

#what to put in change phase?
#health_bar.value and current_phase_hp filledup again
#redder sprite
#phase += 1
#then change_state(GetInPosition)
