extends Node2D

onready var scene_changer = get_node("/root/SceneChanger")

func _ready():
	$Background/Human.set_physics_process(false)

func toggle_pause():
	get_tree().paused = !get_tree().paused


func _on_Play_pressed():
	scene_changer.change_scene("res://world/World.tscn", 0.1)
	toggle_pause()


func _on_Credits_pressed():
	$Menu/Control/Credits.popup()


func _on_Quit_pressed():
	scene_changer.quit()
	toggle_pause()


func _on_Close_pressed():
	$Menu/Control/Credits.hide()
	print("close")