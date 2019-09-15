extends Node2D

onready var scene_changer = get_node("/root/SceneChanger")

func _ready():
	$Background/Human.set_physics_process(false)


func _on_Play_pressed():
	scene_changer.change_scene("res://world/World.tscn")


func _on_Credits_pressed():
	$Menu/Control/Credits.popup()


func _on_Quit_pressed():
	scene_changer.quit()


func _on_Close_pressed():
	$Menu/Control/Credits.hide()
