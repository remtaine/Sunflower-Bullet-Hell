extends Label

var texts = ["LOADING.", "LOADING..", "LOADING..."]

var current_text = 2

func _ready() -> void:
	pass


func _on_Timer_timeout() -> void:
	current_text = (current_text + 1) % texts.size()
	text = texts[current_text]
