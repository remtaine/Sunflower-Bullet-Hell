class_name Hitbox
extends Area2D

export (float) var damage_multiplier
export (bool) var resistant = false

func _ready() -> void:
	owner = get_parent().get_parent().get_parent()

func _on_Hitbox_area_entered(area: Area2D) -> void:
	if owner.team == 0: #check only using player's hitbox!
		if not area.resistant:
			area.owner.damage()
		if not self.resistant:
			owner.damage()
