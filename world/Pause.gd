extends CenterContainer

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("ui_end"):
		toggle_pause()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	visible = get_tree().paused

func _quit_game():
	get_tree().quit()
