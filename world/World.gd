extends Node2D

var wall = preload("res://world/obstacles/Wall.tscn")
var cur_wall

onready var human = $LifeWorld/Human
onready var ghost = $DeathWorld/Ghost

onready var life_world = $LifeWorld
onready var death_world = $DeathWorld

onready var levels = [
	preload("res://world/levels/Level1.tscn"),
	preload("res://world/levels/Level2.tscn")
]
var current_levels = [
]
var cur_lvl_index = 0

var life_is_active = true
signal switched

func _ready():
	current_levels.resize(3)
	current_levels[1] = levels[0].instance()
	current_levels[2] = levels[1].instance()
	
	current_levels[1].connect("level_finished", self, "_on_current_level_finished")
	current_levels[1].connect("obstacle_clicked", self, "_on_Obstacle_clicked")
	current_levels[2].connect("obstacle_clicked", self, "_on_Obstacle_clicked")
	
	current_levels[1].global_position = Vector2.ZERO
	current_levels[2].global_position = current_levels[1].get_node("ConnectPoint").global_position
	
	life_world.call_deferred("add_child",current_levels[1])
	life_world.call_deferred("add_child",current_levels[2])
	
	human.global_position = current_levels[1].get_node("StartingPoint").global_position
	human.spawnpoint = human.global_position
	connect("switched", $DeathWorld/Ghost, "_on_switched")

func _process(delta):
	if Input.is_action_just_pressed("switch"):
		switch()

func switch():
	life_is_active = !life_is_active
	if life_is_active:
		life_world.get_node("Overlay").visible = false
		human.unpause()
		ghost.is_controlled = false
		ghost.velocity = Vector2.ZERO
		death_world.visible = false
	else:
		life_world.get_node("Overlay").visible = true
		human.pause()
		ghost.is_controlled = true
		death_world.visible = true
		ghost.global_position = human.global_position
	emit_signal("switched", life_is_active)

func _on_Obstacle_clicked(obstacle):
	if life_is_active:
		return
	if ghost.global_position.distance_to(obstacle.global_position) > ghost.grab_distance:
		return
	ghost.grab(obstacle)

func _on_current_level_finished():
	if current_levels[0]:
		current_levels[0].call_deferred("queue_free")
	current_levels[0] = current_levels[1]
	current_levels[1] = current_levels[2]
	
	if !cur_wall:
		cur_wall = wall.instance()
		call_deferred("add_child",cur_wall)
	cur_wall.global_position = current_levels[0].global_position
	
	current_levels[1].connect("level_finished", self, "_on_current_level_finished")
	current_levels[1].connect("obstacle_clicked", self, "_on_Obstacle_clicked")
	#cur_lvl_index += 1
	cur_lvl_index=1
	if levels[cur_lvl_index]:
		current_levels[2] = levels[cur_lvl_index].instance()
		current_levels[2].global_position = current_levels[1].get_node("ConnectPoint").global_position
		life_world.call_deferred("add_child",current_levels[2])
		current_levels[2].connect("obstacle_clicked", self, "_on_Obstacle_clicked")

func _on_Human_respawned():
	human.global_position = human.spawnpoint
