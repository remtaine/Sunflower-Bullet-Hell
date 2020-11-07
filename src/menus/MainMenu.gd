class_name MainMenu
extends Node2D

onready var normal_theme = $Audio/Theme
onready var bullet_theme = $Audio/BulletTheme
onready var version_label = $UI/UIControl/Labels/Version

func _ready():
	version_label.text = GlobalInfo.version
