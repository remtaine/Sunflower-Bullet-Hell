class_name Hitbox
extends Area2D

var character_type = null

#	character_type = get_parent().get_parent().character_type
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Hitbox_area_entered(area):
#	if area is Hurtbox:
	if not area is Hurtbox:
		return
	if character_type != area.owner_type:
		area.owner.damage()
		queue_free()
#	elif character_type == "player" and area.owner_type == "enemy":
#		area.owner.damage()
#		queue_free()
