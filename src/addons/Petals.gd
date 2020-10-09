class_name Petals
extends Node2D

onready var petals_visible := get_child_count()
onready var petal_timer = get_parent().get_parent().get_node("Timers/PetalCooldown")

func use_petal():
	petals_visible -= 1
	get_child(petals_visible).visible = false
	if petal_timer.is_stopped():
		petal_timer.start()
		
func reload_petal():
	get_child(petals_visible).visible = true
	petals_visible += 1
	if petals_visible < get_child_count():
		petal_timer.start()
		
func _on_PetalCooldown_timeout():
	reload_petal()
	
