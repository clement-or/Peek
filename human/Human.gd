extends KinematicBody2D

export var speed = 300 # px/s
export var jump_speed = 400 # px/s
export var gravity = 900 #px/s²

var velocity = Vector2(0,0)
var spawnpoint = Vector2()

signal respawned

func _ready():
	pass

func _physics_process(delta):
	_check_input()
	velocity.y += gravity*delta
	velocity = move_and_slide(velocity, Vector2.UP, true)

func _check_input():
	var x_direction = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
	velocity.x = lerp(velocity.x, x_direction*speed, 0.5)
	
	# Vertical input
	if (Input.is_action_pressed("ui_up") && is_on_floor()):
		jump()
	if (Input.is_action_just_released("ui_up")):
		stop_jump()

func jump():
	velocity.y = -jump_speed

func stop_jump():
	if velocity.y < 0:
		velocity.y += -0.5*velocity.y

func pause():
	set_physics_process(false)
func unpause():
	set_physics_process(true)
	
func respawn():
	emit_signal("respawned", spawnpoint)