extends Node

enum CONTROLS {
	KEYBOARD,
	MOUSE
}

const GAME_BORDER_START = Vector2(220, 40)
const GAME_BORDER_END = Vector2(740, 450)

var chosen_music_set = null
var current_player = null
var current_level = null
var last_score : int = 0 
var controls = CONTROLS.KEYBOARD
