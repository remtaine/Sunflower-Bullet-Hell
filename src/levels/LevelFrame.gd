class_name LevelFrame
extends Node2D

onready var lives_label = $HUD/RightSide/LivesLabel
onready var tween = $Addons/Tween

onready var score_label = $HUD/RightSide/ScoreLabel

var score = 0
var shown_score
func _ready():
	add_to_group("frames")
	shown_score = score
	
func _process(delta):
	score_label.text = "SCORE: \n" + String(int(shown_score))

func update_score(scr):
	score += scr
	$Addons/Tween.interpolate_property(self, "shown_score", shown_score, score, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Addons/Tween.start()
