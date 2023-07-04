extends Node3D

const HORIZONTAL_SENS = 0.3
const MAX_DEPTH = 0.4

var pre_move_pos : Vector3
# Called when the node enters the scene tree for the first time.

	
func _input(event):
	
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * HORIZONTAL_SENS))

func move_to_branca(pos):
	var cam = $"../CameraTaco"
	set_position(Vector3(pos.x, pos.y, pos.z - 0.4))
	cam.set_position(Vector3(pos.x, cam.position.y, pos.z))
	pre_move_pos = position

func cue_move(pressed):
	
	if pressed:
		var angle = rotation.y
		var tween = create_tween()
		tween.tween_property(self, "position",Vector3(MAX_DEPTH*sin(angle) + position.x,0, MAX_DEPTH*cos(angle) + position.z), 0.5)
	else:
		var tween = create_tween()
		tween.tween_property(self, "position",pre_move_pos, 0.5)

func get_impulse_coords():
	var angle = rotation.y
	return -Vector3(sin(angle), 0, cos(angle))

