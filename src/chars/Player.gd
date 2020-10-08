class_name Player
extends Character

const GAME_BORDER_START = Vector2(220, 40)
const GAME_BORDER_END = Vector2(740, 450)

var is_bullet_time := false

onready var bullet_time_bar = $Addons/Bars/BulletTimeBar

signal player_hurt

func _ready():
	hp = 3
	var _succesful_connection = connect("player_hurt", level, "update_player_lives")

func _physics_process(_delta):
	position.x = clamp(position.x, GAME_BORDER_START.x, GAME_BORDER_END.x)
	position.y = clamp(position.y, GAME_BORDER_START.y, GAME_BORDER_END.y)

func _input(event):
	if event.is_action_pressed("bullet_time"):
		bullet_time()

func get_hurt(_dmg := 1):
	is_immune = true
	set_collision_layer(0)
	emit_signal("player_hurt", hp)
	.get_hurt()

func die():
	emit_signal("player_hurt", hp)
	.die()
	
func bullet_time():
	var slowed_time := 0.3
	var time_shift_duration:= 0.2
	
	is_bullet_time = !is_bullet_time
	
	if is_bullet_time:
		tween.interpolate_property(Engine, "time_scale", Engine.time_scale, slowed_time, time_shift_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)		
		tween.interpolate_property(self, "speed", speed, normal_speed*2, time_shift_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)		
		
		#TODO add audio change as well!
	else:
		tween.interpolate_property(Engine, "time_scale", Engine.time_scale, 1.0, time_shift_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.interpolate_property(self, "speed", speed, normal_speed, time_shift_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)		
		
		#TODO add audio change as well!
		
	bullet_time_bar.visible = is_bullet_time
	tween.start()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hurt":
		is_immune = false
		set_collision_layer(2)
