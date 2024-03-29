extends KinematicBody2D

export var gravity = 900

var velocity = Vector2(0,0)
var mouse_in = false
var overlap_count = 0
var spawnpoint
signal clicked
signal tween_completed

func _ready():
	spawnpoint = global_position

func _physics_process(delta):
	if velocity.x > 0:
		velocity.x -= 1
	if velocity.x < 0:
		velocity.x += 1
	velocity.y += gravity*delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
func move_to(target):
	set_physics_process(false)
	velocity = Vector2.ZERO
	$Tween.interpolate_property(self, "global_position", global_position, target, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		emit_signal("clicked", self)


func _on_Tween_tween_completed(object, key):
	emit_signal("tween_completed")

func respawn():
	global_position = spawnpoint


func _on_OverlapCheck_body_entered(body):
	overlap_count += 1


func _on_OverlapCheck_body_exited(body):
	overlap_count -= 1
