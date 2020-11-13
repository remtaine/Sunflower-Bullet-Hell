class_name GetInPosition
extends State

export (PoolVector2Array) var phase_positions
var speed_divider := 1.5
var leeway = 5
	
func run(_input):
	owner.direction = owner.global_position.direction_to(phase_positions[owner.phase-1])
	owner.velocity = owner.direction * owner.speed

	owner.velocity = owner.move_and_slide(owner.velocity)
	if owner.global_position.distance_to(phase_positions[owner.phase-1]) < leeway:
		owner.change_state("Moving")
		
func enter():
	owner.speed /= speed_divider
#	owner.change_state("GetInPosition")
	owner.is_immune = true
	owner.modulate = Color(owner.modulate.r, owner.modulate.g, owner.modulate.b, 1.0)
func exit():
	owner.speed *= speed_divider * 1.2 #move faster than before
	owner.is_immune = false
#what to put in change phase?
#health_bar.value and current_phase_hp filledup again
#redder sprite
#phase += 1
#then change_state(GetInPosition)
