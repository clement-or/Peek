extends CenterContainer

onready var scene_changer = get_node("/root/SceneChanger")

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	visible = get_tree().paused

func _quit_game():
	scene_changer.quit()
	print("quit")


func _on_Menu_pressed():
	scene_changer.change_scene("res://menu/Menu.tscn", 0.1)
	print("menu")
