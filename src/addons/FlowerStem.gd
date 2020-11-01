extends Position2D

export (bool) var is_on = true

onready var flower_stem = $FlowerStemTrail

func _ready():
	if not is_on:
		flower_stem.visible = false
		flower_stem.set_process(false)
