extends Node2D

onready var scene_changer = get_node("/root/SceneChanger")

func _ready():
	pass

func _on_Anim_animation_finished(anim_name):
	scene_changer.change_scene("res://menu/Menu.tscn", 2)
