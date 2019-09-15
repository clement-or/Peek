extends Node2D

signal level_finished
signal obstacle_clicked

func _ready():
	var obstacles = $Obstacles.get_children()
	for o in obstacles:
		o.connect("clicked", self, "_on_Obstacle_clicked")

func _on_Checkpoint_level_finished():
	emit_signal("level_finished")
	var obstacles = $Obstacles.get_children()
	for o in obstacles:
		o.call_deferred("queue_free")

func _on_Obstacle_clicked(obstacle):
	emit_signal("obstacle_clicked", obstacle)