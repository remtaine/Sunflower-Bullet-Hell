class_name StandardShipStandShoot
extends StandShoot

func run(_input):
	pass
	#TODO add trigger to change to moving

func enter():
	for bs in owner.bullet_spawners.get_children():
		bs.set_autofire(true)
	owner.get_node("Timers/ShootBurst").start()

func exit():
	for bs in owner.bullet_spawners.get_children():
		bs.set_autofire(false)

func get_raw_input() -> Dictionary:

	inputs = {
		is_moving = false,
		input_direction = Vector2.ZERO,
		is_shooting = true,
	}
	return inputs

func interpret_inputs(input) -> String:
	return "StandShoot"

func _on_ShootBurst_timeout() -> void:
	owner.change_state("Moving")
