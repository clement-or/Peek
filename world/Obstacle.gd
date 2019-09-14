extends KinematicBody2D

export var gravity = 900

var velocity = Vector2(0,0)
var mouse_in = false
signal clicked

func _ready():
	pass

func _physics_process(delta):
	velocity.y += gravity*delta
	velocity = move_and_slide(velocity, Vector2.UP)
	

func _input(event):
	if event.is_action_pressed("click") && mouse_in:
		emit_signal("clicked", self)

func _on_Obstacle_mouse_entered():
	mouse_in = true


func _on_Obstacle_mouse_exited():
	mouse_in = false

func move_to(target):
	set_physics_process(false)
	velocity = Vector2.ZERO
	$Tween.interpolate_property(self, "global_position", global_position, target, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
