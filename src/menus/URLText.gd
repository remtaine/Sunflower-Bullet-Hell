extends RichTextLabel

func _on_Credits_meta_clicked(meta):
	var _shell_open_status = OS.shell_open(meta)
