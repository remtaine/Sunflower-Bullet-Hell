class_name Screenshake
extends Node2D

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

onready var camera = get_parent()
onready var tween = $Tween
onready var frequency = $FrequencyTimer
onready var duration = $DurationTimer

var amplitude = 0
var priority = 0

func _ready():
	frequency.connect("timeout",self,"_on_FrequencyTimer_timeout")
	duration.connect("timeout",self,"_on_DurationTimer_timeout")
	frequency.set_one_shot(true)
	duration.set_one_shot(true)

func start(p = 0, d = 0.3, f = 15, a = 18):
	if self.priority <= p:
		self.priority = p 
		self.amplitude = a + p * 3 
		frequency.set_wait_time(1.0/float(f * (1 + float(p)/10.0)))
		duration.set_wait_time(d)
		
		duration.start()
		frequency.start()
		
		_new_shake()
	
func _new_shake():
	var rand = Vector2()
	randomize()
	rand.x =  rand_range(-amplitude, amplitude)
	rand.y =  rand_range(-amplitude, amplitude)
	change_offset(rand)

func reset():
	change_offset(Vector2.ZERO)
	priority = 0
	
func change_offset(val):
	tween.interpolate_property(camera, "offset", camera.offset, val, frequency.wait_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
func _on_FrequencyTimer_timeout():
	_new_shake()

func _on_DurationTimer_timeout():
	reset()
	frequency.stop()
