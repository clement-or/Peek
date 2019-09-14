extends Area2D

func _ready():
	pass


func _on_RespawnArea_body_entered(body):
	if body.get_name() == "Human":
		body.respawn()
