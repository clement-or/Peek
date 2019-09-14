extends KinematicBody2D

export var speed = 300 # px/s
export var is_controlled = false

var velocity = Vector2(0,0)

func _ready():
	pass

func _physics_process(delta):
	if is_controlled:
		_check_input()
	velocity = move_and_slide(velocity, Vector2.UP, true)

func _check_input():
	var x_direction = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
	velocity.x = lerp(velocity.x, x_direction*speed, 0.2)
	var y_direction = int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up"))
	velocity.y = lerp(velocity.y, y_direction*speed, 0.2)