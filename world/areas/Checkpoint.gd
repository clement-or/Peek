extends Area2D

export var activated = false
signal level_finished

func _ready():
	pass

func _on_Checkpoint_body_entered(body):
	if body.get_name() != "Human" || activated:
		return
	activated = true
	body.spawnpoint = global_position
	emit_signal("level_finished")