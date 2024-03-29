extends KinematicBody2D

export var speed = 300 # px/s
export var is_controlled = false
export var grab_distance = 300 #px
export(NodePath) var gui_path

onready var sm = $AnimTree.get("parameters/playback")
onready var gui = get_node(gui_path)
var is_grabbing = false
var obstacle
var is_holding = false

var velocity = Vector2(0,0)

func _ready():
	sm.start("idle")

func _physics_process(delta):
	if is_controlled:
		_check_input()
	if is_grabbing && obstacle:
		obstacle.global_position = $GrabPoint.global_position
	display_timer()
	velocity = move_and_slide(velocity, Vector2.UP, true)

func _check_input():
	var x_direction = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
	velocity.x = lerp(velocity.x, x_direction*speed, 0.8)
	var y_direction = int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up"))
	velocity.y = lerp(velocity.y, y_direction*speed, 0.8)
	sm.travel("idle")
	"""
	if is_holding:
		sm.travel("hold")
	else:
		if Input.is_action_pressed("ui_right"):
			sm.travel("move_r")
		elif Input.is_action_pressed("ui_left"):
			sm.travel("move_l")
		else:
			sm.travel("idle")
	"""

func grab(o):
	if o == obstacle: 
		stop_grab()
		return
	if is_grabbing:
		stop_grab()
	is_grabbing = true
	is_controlled = false
	velocity = Vector2.ZERO
	
	obstacle = o
	obstacle.set_physics_process(false)
	obstacle.collision_layer = 3
	obstacle.collision_mask = 3
	obstacle.connect("tween_completed", self, "_on_grab_finished")
	obstacle.move_to($GrabPoint.global_position)

func _on_grab_finished():
	is_controlled = true

func stop_grab():
	gui.progress_bar.visible = false
	obstacle.disconnect("tween_completed", self, "_on_grab_finished")
	obstacle.set_physics_process(true)
	obstacle.collision_layer = 1
	obstacle.collision_mask = 1
	obstacle = null
	is_grabbing = false
	
	
func _move_hands_to(point1, point2):
	$Tween.interpolate_property($LHand, "LHand:global_position", $LHand.global_position, point1, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#$Tween.interpolate_property($RHand, "RHand:global_position", $RHand.global_position, point2, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_switched(is_life):
	if is_life && is_grabbing:
		$GrabTimer.start()
		gui.progress_bar.visible = true
	if !is_life:
		if obstacle: stop_grab()
		$GrabTimer.stop()

func _on_GrabTimer_timeout():
	stop_grab()

func display_timer():
	if gui && !$GrabTimer.is_stopped():
		gui.set_progress($GrabTimer.time_left)
