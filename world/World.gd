extends Node2D

onready var life_world = $LifeWorld
onready var death_world = $DeathWorld
var life_is_active = true

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("switch"):
		switch()

func switch():
	life_is_active = !life_is_active
	if life_is_active:
		life_world.get_node("Overlay").visible = false
		life_world.get_node("Human").unpause()
		death_world.get_node("Ghost").is_controlled = false
		death_world.visible = false
	else:
		life_world.get_node("Overlay").visible = true
		life_world.get_node("Human").pause()
		death_world.get_node("Ghost").is_controlled = true
		death_world.visible = true
		death_world.get_node("Ghost").global_position = life_world.get_node("Human").global_position