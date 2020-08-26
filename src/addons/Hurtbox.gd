class_name Hurtbox
extends Area2D

var owner_type = null

func _ready():
	owner = get_parent().get_parent()
	owner_type = owner.character_type

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func _on_Hitbox_area_entered(area):
#	if area is Hurtbox:
#		if owner_type == "enemies" and area.owner_type == "allies":
#			owner.queue_free()
#		elif owner_type == "allies" and area.owner_type == "enemies":
#			owner.queue_free()
