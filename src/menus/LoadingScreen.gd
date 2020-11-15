class_name LoadingScreen
extends Control

var loader
var wait_frames
var time_max = 100 # msec
var current_scene
export (String) var next_scene = "res://src/levels/SplashScreen.tscn"
#Ref<ResourceInteractiveLoader> ResourceLoader::load_interactive(String p_path)

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	goto_scene(next_scene)
	
func _process(time):
	if loader == null:
		# no need to process anymore
		set_process(false)
		return

	# Wait for frames to let the "loading" animation show up.
	if wait_frames > 0:
		wait_frames -= 1
		return

	var t = OS.get_ticks_msec()
	# Use "time_max" to control for how long we block this thread.
	while OS.get_ticks_msec() < t + time_max:
		# Poll your loader.
		var err = loader.poll()

		if err == ERR_FILE_EOF: # Finished loading.
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		elif err == OK:
			update_progress()
		else: # Error during loading.
#			show_error()
			loader = null
			break

func update_progress():
	var progress = float(loader.get_stage()) / loader.get_stage_count()
	# Update your progress bar?
	$Labels/Percent.text = String(progress) + "%"

	# Call this on a paused animation. Use "true" as the second argument to
	# force the animation to update.
#	get_node("animation").seek(progress * length, true)

func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	get_node("/root").add_child(current_scene)

func goto_scene(path): # Game requests to switch to this scene.
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # Check for errors.
#		show_error()
		return
	set_process(true)

	current_scene.queue_free() # Get rid of the old scene.

	# Start your "loading..." animation.
	$Labels/Loading/Timer.start()

	wait_frames = 1
