extends Label


func _ready() -> void:
	pass


func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	GameInfo.current_level.enemy_spawner.set_process(true)
