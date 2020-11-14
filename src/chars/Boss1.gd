class_name Boss1
extends Enemy

onready var health_bar = $UI/UIControl/HealthBar
var phase = 1
var phase_hp : int
var current_phase_hp : int
export (int) var phase_count = 3

onready var health_multiplier = $UI/UIControl/HealthMultiplier

func _ready() -> void:
	health_multiplier.text = "X" + String(phase_count - phase)
	hp = 105
	phase_hp = hp/ phase_count
	current_phase_hp = phase_hp
	
	health_bar.max_value = current_phase_hp
	health_bar.value = current_phase_hp
	
func damage(dmg := 1):
	if !is_immune:
		health_bar.value -= dmg
		current_phase_hp -= dmg
		.damage(dmg)
		if current_phase_hp <= 0:
			GameInfo.current_level.screenshake()
			if hp != 0 and phase < phase_count:
				change_state("ChangePhase")

func die():
	GameInfo.current_level.spawn_coins_on_bullets()
	GameInfo.current_level.win_timer.start()
	GameInfo.current_level.change_win_theme()
	.die()
#TODO change death
