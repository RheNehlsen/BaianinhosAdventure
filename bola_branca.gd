extends RigidBody3D

var bodyState : PhysicsDirectBodyState3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_body_entered(body):
	
	if body.is_in_group("bolas"):
		var collision_normal = bodyState.get_contact_local_normal(0)
		collision_normal.y = 0
		body.apply_central_impulse(1.5*collision_normal)
		apply_central_impulse(-1.5*collision_normal)
		
func _integrate_forces(state):
	bodyState = state
