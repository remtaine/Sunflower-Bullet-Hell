class_name URLButton
extends TextureButton

export (String) var url_path



func _on_Github_pressed() -> void:
	var _shell_open_status = OS.shell_open(url_path)
